# Roberta dotfiles

Minimal macOS dotfiles for Roberta's Next.js + Expo work. This repo is derived
from `/Users/gabimoncha/development/dotfiles`, but it deliberately keeps only
the portable setup pieces needed for this machine.

Do not run `./bin/setup`, `./bin/link-dotfiles`, Homebrew writers, restore
scripts, or app-state scripts from this repo on Gabimoncha's current Mac. The
real integration target is Roberta's Mac.

## Roberta Setup

Clone to this exact path:

```bash
mkdir -p ~/development
git clone --recurse-submodules https://github.com/rbrtpop/dotfiles.git ~/development/dotfiles
cd ~/development/dotfiles
./bin/setup
```

If the Xcode Command Line Tools installer opens, finish that installer and run
`./bin/setup` again.

After setup finishes, open a new terminal or run:

```bash
exec zsh
```

## Included

- Minimal Homebrew bundle: Git, Watchman, Ghostty, Cursor, and Geist Mono Nerd Font.
- Standalone `mise` installed at `~/.local/bin/mise`.
- Standalone Codex installed at `~/.local/bin/codex` with runtime under `~/.codex/packages/standalone`.
- pnpm-first mise toolchain for Next.js + Expo: Node 24 LTS, pnpm, EAS CLI, Turbo, Vercel, GitHub CLI, tmux, Neovim, search tools, shell niceties, and Socket Firewall.
- GitHub authentication setup: `gh auth login`, local Git identity, SSH key creation/upload, and `origin` remote migration from HTTPS to SSH.
- Touch ID for terminal `sudo` prompts through `/etc/pam.d/sudo_local` when macOS supports it.
- Same dotfile symlink model as the source repo: files under `home/` link into `$HOME`, and `nvim` links to `~/.config/nvim`.
- Same alias definitions as the source repo.
- Oh My Zsh, Powerlevel10k, `zsh-autosuggestions`, `zsh-fzf-history-search`, TPM, and tmux plugins.

## Excluded

- Full Xcode, Xcodes, iOS platform downloads, simulators, and Android Studio.
- Raycast, Mackup, Synology/iCloud restore flows, macOS defaults automation, Finder sidebar changes, and app-state restore.
- Gabimoncha's Codex config, memories, auth, histories, or local machine state.
- Personal apps and workstation-specific configs such as Karabiner, AeroSpace, Zed, and superwhisper.

## Local Development Safety

In `/Users/gabimoncha/development/dotfiles-robi`, use only static checks:

```bash
git status --short
git diff --check
bash -n bin/*
zsh -n home/.zshrc home/.zprofile home/.zshenv home/.config/zsh/*.zsh
git submodule status
```

Do not validate by running setup, link, restore, Homebrew, Xcode, or commands
that write into live `$HOME` on Gabimoncha's machine.
