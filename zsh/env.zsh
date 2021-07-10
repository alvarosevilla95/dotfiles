export DOTFILES=/Users/alvaro/dotfiles
export PATH="$PATH:$DOTFILES/bin"
export PATH="$PATH:/Users/alvaro/.cargo/bin"
export PATH="$PATH:/Developer/bin"
export GOPATH=~/Developer/go
export PATH=$PATH:$GOPATH/bin

alias vimrc="vim ~/.config/nvim/init.vim"
alias zshrc="vim ~/.zshrc"

alias senv="source $DOTFILES/zsh/env.zsh"

alias v="nvr"
alias vi="nvim"
alias vim="nvim"
alias vs="vim -S"
alias vims="vim -S"

alias ls="exa"
alias ll="exa -lF"
alias la="exa -alF"

alias tc="toggle_colors"
alias f='fzf_z'
alias ds='f=$(fd --type f  . ~/dotfiles | fzf --preview="bat {} --color=always --style=\"numbers\"") && vim $f'
alias pwdc="pwd|pbcopy"

alias k="kubectl"
alias kl="kubectl logs"
alias klf="kubectl logs -f"
alias kc="kconfig"

alias ql='quick-look'
alias pman='man-preview'
# cdf - cd to current Finder window. pfd for echo. pfs echo Finder selection
alias ydl='youtube-dl -f best'

alias github='gh repo view --web'
alias gpr='gh pr view --web'
alias gclone='gh repo clone'

alias ts='tools'

alias epoch='date +%s'

source $DOTFILES/zsh/functions.zsh
