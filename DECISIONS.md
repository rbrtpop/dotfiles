# Decisions

## Roberta's Mac Is the Integration Target

This repo is developed locally at `/Users/gabimoncha/development/dotfiles-robi`,
but setup must not be run on Gabimoncha's current Mac. The real integration
target is Roberta's Mac.

All setup instructions use the exact clone path:

```bash
~/development/dotfiles
```

That keeps `DOTFILES_ROOT`, the `dotfiles` shell helper, and update checks
aligned with the source dotfiles behavior.

## Minimal Over Full-Machine Restore

The source repo at `/Users/gabimoncha/development/dotfiles` is a full-machine
development environment. Roberta's repo keeps only the reviewed subset needed
for Next.js + Expo work:

- Homebrew for GUI apps and tools not owned by mise.
- `mise` for runtimes and global CLIs.
- Standalone installers for `mise` and Codex.
- Symlinked dotfiles under `home/`.
- `nvim` as a git submodule linked to `~/.config/nvim`.

Full Xcode, simulators, Android Studio, Raycast, Mackup, macOS defaults, and
app-state restore are explicitly out of scope for this pass.

## pnpm Is the Default Package Manager

The source repo defaults npm package execution to Bun. Roberta's setup defaults
to pnpm:

```toml
[settings.npm]
package_manager = "pnpm"
```

Socket Firewall is still installed because the copied aliases and `npx` wrapper
expect `sfw` when pnpm is available.

## Fresh Identity

Tracked `.gitconfig` does not set `user.name` or `user.email`. Roberta's Git
identity belongs in `~/.gitconfig.local`, which is included by the tracked
config. Codex is installed fresh; Gabimoncha's Codex memories, auth state,
histories, plugin state, and archives are not restored.

## Static Local Validation

Validation in `/Users/gabimoncha/development/dotfiles-robi` must remain
static-only unless a future task explicitly says otherwise. Acceptable local
checks include:

```bash
git status --short
git diff --check
bash -n bin/*
zsh -n home/.zshrc home/.zprofile home/.zshenv home/.config/zsh/*.zsh
git submodule status
```

Do not validate by running setup, link, restore, Homebrew, Xcode, or commands
that write into live `$HOME` on Gabimoncha's machine.
