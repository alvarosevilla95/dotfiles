source ~/.zshrc
export GOPATH=~/Developer/go
export PATH="$PATH:$GOPATH/bin"

if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
  exec startx
fi
