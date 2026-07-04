# Dotfiles

This repo sets up the Mac for coding projects, especially projects that have a Next.js web app and an Expo mobile app.

It is a small, portable version of gabimoncha/dotfiles. The goal is not to copy his whole computer. The goal is to install the shared coding tools and terminal setup.

## First Setup

Run this on Mac:

```bash
mkdir -p ~/development
git clone --recurse-submodules https://github.com/rbrtpop/dotfiles.git ~/development/dotfiles
cd ~/development/dotfiles
./bin/setup
```

Do not run setup with `sudo`. The script will ask for the Mac password only
when a specific step needs administrator access.

If the Xcode Command Line Tools installer opens, finish that installer, then
run setup again:

```bash
./bin/setup
```

During setup, expect a few normal prompts:

- The Mac password for Homebrew or Touch ID sudo setup.
- A GitHub login in the terminal or browser.
- Git name and email setup. If unsure, use the GitHub noreply email suggested
by the script.
- Existing terminal config files may be backed up under  
`~/.dotfiles-backups/<date-and-time>/` before this repo links its versions.

## After Setup

Open a new Ghostty or Cursor terminal. You can also reload the current terminal
with:

```bash
exec zsh
```

Then run these checks from the dotfiles folder:

```bash
cd ~/development/dotfiles
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

Some apps still need their own sign-in after setup, such as Cursor, Codex, Expo/EAS, Vercel, or Apple account apps. Project-specific `.env` files and secrets are not managed by this repo.

## What This Setup Installs Or Changes

- Homebrew packages and apps from `Brewfile`, including Git, Watchman, Cursor, Ghostty, Expo Orbit, Stats, superwhisper, a Nerd Font, Amphetamine, and Transporter.
- Standalone `mise` at `~/.local/bin/mise`.
- Standalone Codex at `~/.local/bin/codex`, with fresh Codex state under `~/.codex`.
- Node 24, pnpm, Ruby, GitHub CLI, EAS CLI, Turbo, Vercel, tmux, Neovim, ripgrep, fd, fzf, jq, yq, lazygit, bat, eza, zoxide, and Socket Firewall through `mise`.
- pnpm as the default JavaScript package manager.
- Zsh, Oh My Zsh, Powerlevel10k, zsh plugins, aliases, shell helpers, tmux config, and tmux plugins.
- Dotfile symlinks from this repo's `home/` folder into Roberta's real home folder.
- The `nvim` folder linked to `~/.config/nvim`.
- GitHub authentication, SSH key creation/upload, and changing this repo's `origin` remote from HTTPS to SSH after SSH works.
- Touch ID for terminal `sudo` prompts when the Mac supports Apple's `/etc/pam.d/sudo_local` hook.

## Updating Later

On Mac:

```bash
cd ~/development/dotfiles
./bin/dotfiles-update
./bin/setup
```

`dotfiles-update` pulls the latest repo changes. `setup` applies package,
symlink, shell, tmux, GitHub, and toolchain changes.

## For Coding Agents

Read `AGENTS.md` before changing this repo.

It explains changes in plain English:

- What changed.
- Why it matters.
- What the user needs to run or sign into.
- What was intentionally left out.

Do not commit changes unless the user explicitly asks for a commit. Keep changes small and update the docs when setup behavior changes.

## Local Development Safety

Use static checks only:

```bash
git status --short
git diff --check
bash -n bin/*
zsh -n home/.zshrc home/.zprofile home/.zshenv home/.config/zsh/*.zsh
git submodule status
```

Do not validate by running setup, link, restore, Homebrew, Xcode, or commands that write into live `$HOME`