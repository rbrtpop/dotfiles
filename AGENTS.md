# Roberta Dotfiles Agent Guide

## Mission

Help build a minimal, reviewable dotfiles repo for Roberta's Mac. Be practical:
prefer narrow changes, document assumptions, and do not copy Gabimoncha's full
machine restore model unless Roberta needs it.

## Hard Boundaries

- Do not run setup, bootstrap, link, restore, Homebrew, Mackup, Raycast, Xcode,
  simulator, app-state, or macOS defaults commands on Gabimoncha's current Mac.
- Do not mutate live `$HOME` from this repo.
- Do not restore Gabimoncha's app state, Codex state, auth state, or local
  machine state into this repo.
- Do not revert edits by other agents or users.
- Use `apply_patch` for manual file edits.

## Source of Truth

Use `/Users/gabimoncha/development/dotfiles` as source material for structure
and prior decisions. Treat it as reference material, not as a setup command
source to run locally.

This repo's Roberta integration path is:

```bash
~/development/dotfiles
```

## Owned Files

Docs own:

- `README.md`
- `QUICKSTART.md`
- `DECISIONS.md`
- `AGENTS.md`
- `.gitignore`

Keep those files aligned when setup scope changes.

Other slices may add portable dotfile source under `home/` or submodule
metadata such as `.gitmodules`. Do not revert those files; update the docs when
their scope changes the setup contract.

## Validation

Use static-only checks locally:

```bash
git status --short
git diff --check
bash -n bin/*
zsh -n home/.zshrc home/.zprofile home/.zshenv home/.config/zsh/*.zsh
git submodule status
```

If future scripts are added, inspect them with static syntax checks before any
Roberta-machine integration run. Do not run them on Gabimoncha's current Mac.
