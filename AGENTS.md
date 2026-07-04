# Dotfiles Agent Guide

## Role

You are helping maintain this Mac setup. The user has no technical background, so do not make her translate implementation details. Explain the effect of a change in plain English, choose a cautious default, and ask for input only when the decision is truly personal or account-specific.

Examples of good questions:

- Which GitHub account should this Mac use?
- Do you want this app installed?
- Do you have the Mac administrator password available?

Examples of bad questions:

- Which script should I edit?
- Should I use Homebrew or mise for this tool?
- Which symlink strategy do you prefer?

Make the technical choice yourself after reading the repo.

## Repository Purpose

This repo is a minimal dotfiles setup for this Mac. It is derived from gabimoncha/dotfiles full dotfiles repo, but it deliberately keeps only the shared setup needed for Next.js, Expo, and coding-agent work.

The integration path on this Mac is:

```bash
~/development/dotfiles
```

The first clone should use HTTPS because the Mac will not have GitHub SSH ready
yet:

```bash
git clone --recurse-submodules https://github.com/rbrtpop/dotfiles.git ~/development/dotfiles
```

After setup authenticates GitHub and verifies SSH, `bin/auth-setup` changes
the repo remote to:

```bash
git@github.com:rbrtpop/dotfiles.git
```

## Hard Safety Rules

- Do not run setup, bootstrap, link, restore, Homebrew, Mackup, Raycast, Xcode,
  simulator, app-state, macOS defaults, auth, Touch ID, or `mise install`
  commands on gabimoncha's current Mac.
- Do not mutate live `$HOME` from this repo when working locally in
  `~/development/dotfiles-robi`.
- Do not copy gabimoncha's app state, Codex state, Codex memories, auth state,
  histories, archives, keys, tokens, or local machine state into this repo.
- Do not add full Xcode, simulators, Android Studio, Raycast, Mackup, or
  full-machine restore flows unless the user explicitly asks for that scope.
- Do not edit Apple's managed `/etc/pam.d/sudo` file. Touch ID sudo setup must
  use `/etc/pam.d/sudo_local` through `bin/configure-sudo-touch-id`.
- Do not hardcode this Mac secrets, tokens, API keys, project credentials, or
  private `.env` contents.
- Do not commit changes unless the user explicitly asks for a commit.
- Do not revert edits made by other users or agents unless the user explicitly
  asks for that.
- Use `apply_patch` for manual edits.

## Codebase Map

- `README.md`: Roberta-facing explanation of what this repo does and how to
  run it.
- `QUICKSTART.md`: short command list for first setup and verification.
- `DECISIONS.md`: setup decisions and why this repo differs from Gabimoncha's
  full dotfiles.
- `AGENTS.md`: instructions for coding agents.
- `Brewfile`: Homebrew packages, GUI apps, fonts, and Mac App Store apps.
- `home/`: dotfiles that are symlinked into Roberta's real home folder.
- `home/.config/mise/config.toml`: runtimes and CLI tools installed by `mise`.
- `home/.config/zsh/*.zsh`: shell behavior, aliases, functions, path setup,
  and mise integration.
- `home/.gitconfig`: tracked Git defaults. User identity belongs in
  `~/.gitconfig.local`, not in the repo.
- `home/Library/Application Support/com.mitchellh.ghostty/config`: Ghostty
  terminal config.
- `nvim`: Neovim config linked to `~/.config/nvim`.
- `bin/setup`: first-run orchestrator. Run only on Roberta's Mac.
- `bin/preflight`: safe checks that setup needs before continuing.
- `bin/ensure-mise-standalone`: installs standalone `mise` into
  `~/.local/bin/mise` and removes Homebrew-owned mise if present.
- `bin/ensure-codex-standalone`: installs standalone Codex into
  `~/.local/bin/codex` and avoids Homebrew-owned Codex.
- `bin/link-dotfiles`: backs up existing files and creates symlinks from this
  repo into `$HOME`.
- `bin/check-mise-tools`: verifies mise-owned commands are installed and
  resolve through mise shims.
- `bin/auth-setup`: signs into GitHub, configures Git identity, creates or
  reuses an SSH key, uploads it to GitHub, and switches `origin` to SSH.
- `bin/configure-sudo-touch-id`: enables or checks Touch ID for terminal
  `sudo` prompts through `/etc/pam.d/sudo_local`.
- `bin/setup-tmux`: installs TPM and tmux plugins.
- `bin/dotfiles-update`: pulls repo updates and submodules on Roberta's Mac.

## Setup Flow

`bin/setup` runs these steps in order:

1. Refuses to run as root.
2. Ensures Xcode Command Line Tools exist. If macOS opens an installer, setup
   exits and asks for a rerun after the installer finishes.
3. Initializes git submodules.
4. Runs `bin/preflight`.
5. Enables Touch ID for terminal `sudo` prompts when supported.
6. Installs Homebrew if missing and applies `Brewfile`.
7. Installs standalone mise and standalone Codex.
8. Links dotfiles from `home/` and links `nvim` to `~/.config/nvim`.
9. Installs mise tools from `home/.config/mise/config.toml`.
10. Installs Oh My Zsh, Powerlevel10k, and zsh plugins.
11. Verifies mise tools.
12. Runs GitHub authentication and SSH setup.
13. Installs tmux plugin manager and plugins.
14. Prints a shell reload hint.

## Validation

Local validation on gabimoncha's current Mac must stay static-only:

```bash
git status --short
git diff --check
bash -n bin/*
zsh -n home/.zshrc home/.zprofile home/.zshenv home/.config/zsh/*.zsh
git submodule status
```

Do not validate local changes by running `./bin/setup`, `./bin/link-dotfiles`,
`brew bundle`, `mise install`, `bin/auth-setup`,
`bin/configure-sudo-touch-id --enable`, or anything else that writes into
`$HOME` or system config on Gabimoncha's Mac.

On this Mac, after an explicit integration run, useful checks are:

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
tmux -V
nvim --version
```

## Change Guidance

- If adding or removing a Mac app or Homebrew package, edit `Brewfile` and
  update the docs that list installed apps.
- If adding or removing a runtime or CLI tool, edit
  `home/.config/mise/config.toml` and update `bin/check-mise-tools` when the
  command should be smoke-tested.
- If changing shell aliases or functions, edit files under
  `home/.config/zsh/`.
- If changing which files are linked into `$HOME`, edit `bin/link-dotfiles` and
  update `README.md` and `DECISIONS.md`.
- If changing GitHub setup, keep the HTTPS-first clone and SSH-after-auth
  behavior. Do not hardcode identity, email, tokens, or account secrets.
- If changing Touch ID sudo behavior, keep the implementation limited to
  `/etc/pam.d/sudo_local` and preserve the check mode.
- If setup behavior changes, update `README.md`, `QUICKSTART.md`, and
  `DECISIONS.md` in the same change unless there is a clear reason not to.
- Keep changes narrow. This repo should remain a minimal Mac setup, not a
  full gabimoncha machine restore.

## Communication Style For Roberta

When reporting work, lead with the practical effect:

- What changed.
- What Roberta needs to run.
- Which prompts or sign-ins she should expect.
- What remains manual.

Avoid jargon when possible. If a term matters, define it briefly. For example:
say "a symlink is a shortcut from your home folder to this repo" instead of
assuming she knows what a symlink is.
