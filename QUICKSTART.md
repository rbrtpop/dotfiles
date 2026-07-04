# Quickstart

## Roberta's Mac

```bash
mkdir -p ~/development
git clone --recurse-submodules https://github.com/rbrtpop/dotfiles.git ~/development/dotfiles
cd ~/development/dotfiles
./bin/setup
```

If setup opens the Xcode Command Line Tools installer, finish the installer and
rerun:

```bash
./bin/setup
```

Reload the shell after setup:

```bash
exec zsh
```

## Verification On Roberta's Mac

```bash
./bin/check-mise-tools
./bin/configure-sudo-touch-id --check
gh auth status --hostname github.com
ssh -T git@github.com
git remote get-url origin
codex doctor --json
pnpm --version
eas --version
turbo --version
vercel --version
watchman --version
tmux -V
nvim --version
```

## Local Development Checks

On Gabimoncha's current Mac, do not run setup. Use static checks only:

```bash
cd /Users/gabimoncha/development/dotfiles-robi
git status --short
git diff --check
bash -n bin/*
zsh -n home/.zshrc home/.zprofile home/.zshenv home/.config/zsh/*.zsh
git submodule status
```

## Scope

Included: Ghostty, Cursor, standalone mise, standalone Codex, pnpm-first
Next.js + Expo tooling, same aliases, same dotfile symlink model, and the same
`~/.config/nvim -> ~/development/dotfiles/nvim` symlink behavior.

Excluded: full Xcode, simulators, Android Studio, Raycast, Mackup, macOS
defaults, app-state restore, and Gabimoncha's local Codex state.
