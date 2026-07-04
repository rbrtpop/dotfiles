typeset -U path

path=(
  "$HOME/bin"
  "$HOME/.local/bin"
  "/opt/homebrew/bin"
  "/opt/homebrew/sbin"
  "/usr/local/bin"
  "/usr/local/sbin"
  "$HOME/.local/share/mise/shims"
  "$HOME/scripts"
  "/usr/bin"
  "/bin"
  "/usr/sbin"
  "/sbin"
  "$path[@]"
)

export PATH
