<!--
Write for a reviewer who will not open the files. The reviewer is Roberta,
and she is not technical. Use short, plain sentences. Explain each tool name
the first time you use it, for example "Homebrew, the app that installs
other apps". Show a file path or command only when she must type it or see it.
Delete any section that does not apply.
-->

## Why

<!-- One or two sentences: the problem or request that this change fixes. Example: "Node had a security fix. This change installs it." -->

## What changes

<!--
One picture. Pick the smallest view that makes the point:
- A before-and-after table of what she sees: an app, a terminal command,
  a shortcut, or a question that setup asks.
- A Mermaid flowchart when the change adds, removes, or moves a setup step.
  Boxes are steps, arrows mean "then", and diamonds are questions that
  setup asks her.
Then add up to three bullets: what she will notice, what stays the same,
and what you left out on purpose.
Name each new prompt (Mac password, GitHub sign-in, Touch ID) and each long
wait, for example "the first setup builds Ruby and takes 5 to 10 minutes".
-->

**Look at:** <!-- the one change that needs a careful look, in plain words. Example: "the new step that changes how the Mac asks for its password in the terminal" -->

## Evidence

<!--
This repo has no automatic checks on GitHub. List the checks that you ran:
the static checks in AGENTS.md ("bash -n", "zsh -n", "git diff --check",
"git submodule status") and any other check that changes nothing on a Mac.
Give each check one line of plain meaning, for example "the setup scripts
have no syntax errors".
Then say what stays unchecked. Agents must not run setup on any Mac except
Roberta's, so a real setup run is usually unchecked. Say so.
-->

## Merge danger

**Door:** <!-- two-way: undo this pull request, run setup again, and the Mac is back as before. one-way: undo does not restore it, for example a GitHub sign-in, a key uploaded to GitHub, the Mac's password settings for the terminal (Touch ID sudo), or deleted app data. -->
**Blast radius:** <!-- one word, e.g. none, docs, terminal, one app, GitHub, whole setup -->

<!-- One or two sentences: what could break on her Mac, and how she would notice. Example: "If this is wrong, new terminal windows show an error. Setup saves her old files in ~/.dotfiles-backups/ first." -->

## After merge

<!--
The exact steps she does, in order. Put commands in a code block that she
can copy. Usually:

    cd ~/development/dotfiles
    ./bin/dotfiles-update
    ./bin/setup

Then "Open a new terminal window." After the steps, list what setup asks
her (password, sign-in, Touch ID), how long it takes, and one check that
shows it worked. For a change that does nothing on the Mac, such as docs
only, write "Nothing to do on the Mac."
-->
