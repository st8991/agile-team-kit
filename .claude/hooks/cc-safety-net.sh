#!/usr/bin/env bash
# PreToolUse hook: runs CC Safety Net (github.com/kenryu42/cc-safety-net) at a
# pinned version, after checking the npm tarball against a pinned sha512.
#
# Why a wrapper instead of `npx cc-safety-net@latest`: the kit never auto-updates
# third-party code (team/SKILLS.md, adoption rule 1), and `npx` adds ~0.8 s to
# every tool call. This installs once per machine into a cache and then runs
# `node` directly (~0.1 s).
#
# Input: the hook JSON on stdin. Output: CC Safety Net's allow/deny JSON.
# If the pinned copy can't be installed (no network, checksum mismatch), Bash
# calls are denied with a message to report it, and file tools are allowed, so
# the run can still write its standup and report. The team's rules and policy
# live in .cc-safety-net/ at the repo root.
#
# To upgrade: change both values below in a PR the owner merges. Take the new
# integrity from `npm view cc-safety-net@<version> dist.integrity`.
set -euo pipefail

readonly PINNED_VERSION="2.7.3"
readonly PINNED_INTEGRITY="sha512-QeXklfHnL7yr1A7w0kQOPoDNaJPIBE9MgmQD9q0Oo5Up10201f7OnWkX7e3OslYqjN/gEbWEvd+kyoVu0JHaJA=="
readonly CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/agile-team-kit/cc-safety-net-${PINNED_VERSION}"
readonly ENTRY_POINT="${CACHE_DIR}/package/dist/bin/cc-safety-net.js"

hook_input="$(cat)"

work_dir=""
cleanup_work_dir() { if [ -n "$work_dir" ] && [ -d "$work_dir" ]; then rm -rf -- "$work_dir"; fi; }
trap cleanup_work_dir EXIT

install_pinned_copy() {
  local tarball actual_integrity
  work_dir="$(mktemp -d)"
  (cd "$work_dir" && npm pack "cc-safety-net@${PINNED_VERSION}" --silent --ignore-scripts >/dev/null 2>&1) || return 1
  tarball="${work_dir}/cc-safety-net-${PINNED_VERSION}.tgz"
  [ -f "$tarball" ] || return 1
  actual_integrity="sha512-$(openssl dgst -sha512 -binary "$tarball" | base64 | tr -d '\n')"
  if [ "$actual_integrity" != "$PINNED_INTEGRITY" ]; then
    echo "cc-safety-net ${PINNED_VERSION}: checksum mismatch, refusing to install" >&2
    return 1
  fi
  mkdir -p "${work_dir}/extract" && tar -xzf "$tarball" -C "${work_dir}/extract"
  mkdir -p "$(dirname "$CACHE_DIR")"
  # Parallel agents may race here; a rename is atomic, and losing the race is fine.
  mv -T "${work_dir}/extract" "$CACHE_DIR" 2>/dev/null || [ -f "$ENTRY_POINT" ]
}

deny_bash_while_unprotected() {
  local tool_name
  tool_name="$(printf '%s' "$hook_input" | node -e 'let d="";process.stdin.on("data",c=>d+=c).on("end",()=>{try{process.stdout.write(String(JSON.parse(d).tool_name||""))}catch{}})')"
  [ "$tool_name" = "Bash" ] || exit 0
  printf '%s\n' '{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"deny","permissionDecisionReason":"CC Safety Net could not be installed at its pinned version, so shell commands are blocked. Stop build work and report this under Blockers in the standup and report (see .claude/hooks/cc-safety-net.sh)."}}'
  exit 0
}

if [ ! -f "$ENTRY_POINT" ]; then
  install_pinned_copy || deny_bash_while_unprotected
fi

printf '%s' "$hook_input" | node "$ENTRY_POINT" hook --coding-cli
