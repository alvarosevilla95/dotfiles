export ZSH="/home/alvaro/.oh-my-zsh"
ZSH_THEME="cbira"
HYPHEN_INSENSITIVE="true"
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
setopt appendhistory autocd extendedglob nomatch
bindkey -v
zstyle :compinstall filename '/home/alvaro/.zshrc'
autoload -Uz compinit
compinit
plugins=(git colored-man-pages)
source $ZSH/oh-my-zsh.sh

export EDITOR='vim'

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# Go Settings
#export GOPATH=~/go
#export PATH=$PATH:$GOPATH/bin

# Setup FZF 
# ---------
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
if [[ ! "$PATH" == */home/alvaro/.fzf/bin* ]]; then
  export PATH="$PATH:/home/alvaro/.fzf/bin"
fi

# FZF Auto-completion
# ---------------
[[ $- == *i* ]] && source "/Users/alvaro/.fzf/shell/completion.zsh" 2> /dev/null

# FZF Key bindings
# ------------
#source "/Users/alvaro/.fzf/shell/key-bindings.zsh"
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
