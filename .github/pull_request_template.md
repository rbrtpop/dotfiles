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
One picture, with a Before and an After. Draw two diagrams, Before and
After, or draw one diagram and mark the changed parts with
`classDef changed`. For a new thing, write "Before: none."

Pick the diagram with one question: does the next step depend on an input
from outside, which can come late, come wrong, or not come?
- Yes: a Mermaid state diagram (stateDiagram-v2). An outside input is
  something that the Mac waits for: Roberta (her Mac password, Touch ID,
  a GitHub sign-in), a download, a timer, or a cancel. A state is a place
  where the thing waits, for example "Waiting for your Mac password" or
  "Downloading the Xcode tools". An arrow is the event that moves it on.
  Draw the arrows for the bad events too (timeout, error, cancel, retry),
  because the change can go wrong there.
- No: a Mermaid flowchart. The procedure runs from start to end with the
  data that it has, for example setup steps that run alone, such as "Link
  the settings files" or "Install the apps in the list". Boxes are steps,
  arrows mean "then", and diamonds are decisions on that data.
- No diagram fits (a new app version, a renamed command, a shortcut): a
  table of old and new values, a diff, or pseudocode.
Write every label in plain words that she knows: "Type your Mac password",
not "sudo". Name the bad events the same way, for example "Wrong
password", "No internet", or "You closed the window".
Add up to three bullets for what the picture misses, including what you
left out on purpose. Say what she will notice and what stays the same.
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
