HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory autocd extendedglob nomatch
bindkey -v
zstyle :compinstall filename '/home/alvaro/.zshrc'
autoload -Uz compinit
compinit

BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

#export GOPATH=~/go
#export PATH=$PATH:$GOPATH/bin

export ZSH=/Users/alvaro/.oh-my-zsh
ZSH_THEME="bira"
plugins=(
  git
  go
  colored-man-pages
)
source $ZSH/oh-my-zsh.sh


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# Setup fzf
# ---------
if [[ ! "$PATH" == */home/alvaro/.fzf/bin* ]]; then
  export PATH="$PATH:/home/alvaro/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/Users/alvaro/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/Users/alvaro/.fzf/shell/key-bindings.zsh"
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
