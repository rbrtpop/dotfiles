# Mise-aware one-off npm package runner for zsh.
#
# What this gives you:
# - `npx <pkg>` and `px <pkg>` run through the package manager selected by mise.
# - Project-local `mise.toml` settings override your global mise config.
#
# To adopt this in another zsh setup:
# 1. Install mise and activate it before sourcing this file:
#      eval "$(mise activate zsh)"
# 2. Set your preferred global default:
#      mise settings set npm.package_manager pnpm
#    or add this to `~/.config/mise/config.toml`:
#      [settings.npm]
#      package_manager = "pnpm"
# 3. Optionally override per project in `mise.toml`:
#      [settings.npm]
#      package_manager = "pnpm"
# 4. Source this file from `.zshrc` after mise activation:
#      [ -r "$HOME/.config/zsh/mise-npx.zsh" ] && source "$HOME/.config/zsh/mise-npx.zsh"
#
# Supported mise values are `pnpm` and `auto`. This wrapper prefers
# project-local binaries, routes pnpm through Socket Firewall Free, deliberately
# refuses npm/yarn/Bun runners, and treats `auto` as pnpm-only because this Mac
# does not install Bun.

_mise_npm_package_manager() {
  local manager

  if ! command -v mise >/dev/null 2>&1; then
    print -u2 "npx: mise is required to resolve npm.package_manager"
    return 1
  fi

  if ! manager="$(mise settings get npm.package_manager)"; then
    print -u2 "npx: could not read mise npm.package_manager"
    return 1
  fi

  case "$manager" in
    pnpm|auto)
      print -r -- "$manager"
      ;;
    bun|bunx|aube|npm|yarn)
      print -u2 "npx: mise selected '$manager', but this setup only installs pnpm"
      return 1
      ;;
    "")
      print -u2 "npx: mise did not return npm.package_manager"
      return 1
      ;;
    *)
      print -u2 "npx: unsupported mise npm.package_manager '$manager'"
      return 1
      ;;
  esac
}

_mise_npm_auto_package_manager() {
  if command -v pnpm >/dev/null 2>&1; then
    print -r -- "pnpm"
  else
    print -u2 "npx: mise npm.package_manager is auto, but pnpm is not on PATH"
    return 1
  fi
}

_mise_npm_effective_package_manager() {
  local manager

  manager="$(_mise_npm_package_manager)" || return
  if [[ "$manager" == "auto" ]]; then
    _mise_npm_auto_package_manager
  else
    print -r -- "$manager"
  fi
}

_mise_npm_require_runner() {
  case "$1" in
    pnpm)
      command -v pnpm >/dev/null 2>&1 || {
        print -u2 "npx: mise selected pnpm, but pnpm is not on PATH"
        return 1
      }
      command -v sfw >/dev/null 2>&1 || {
        print -u2 "npx: mise selected pnpm, but sfw is not on PATH"
        return 1
      }
      ;;
    *)
      print -u2 "npx: unsupported runner '$1'"
      return 1
      ;;
  esac
}

_mise_npm_has_local_bin() {
  local bin="${1:-}"

  [[ -n "$bin" && "$bin" != -* && "$bin" != */* && -x "node_modules/.bin/$bin" ]]
}

_mise_npm_run_pnpm() {
  local bin

  bin="${1:-}"

  while [[ "$bin" == "--yes" || "$bin" == "-y" ]]; do
    shift
    bin="${1:-}"
  done

  if _mise_npm_has_local_bin "$bin"; then
    command sfw pnpm exec "$@"
  else
    command sfw pnpm dlx "$@"
  fi
}

npx() {
  local manager

  manager="$(_mise_npm_effective_package_manager)" || return
  _mise_npm_require_runner "$manager" || return

  case "$manager" in
    pnpm)
      _mise_npm_run_pnpm "$@"
      ;;
  esac
}

px() {
  npx "$@"
}
