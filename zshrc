# BASE16_SHELL=$HOME/.config/base16-shell/
# [ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

# alias vim="nvim"
[[ -s "/home/alvaro/.gvm/scripts/gvm" ]] && source "/home/alvaro/.gvm/scripts/gvm"
alias vi="vim"
alias v="vim"
alias suspend="sudo systemctl suspend"
alias spoweroff="sudo poweroff"
alias gclone="~/.scripts/github.sh"
#alias ccat="pygmentize"
alias wifi-inn="sudo netctl start wlp2s0-INNOVACION"
alias wifi-home="sudo netctl start wlp2s0-MOVISTAR_75FA"
alias reminders="cat ~/.reminders"
alias ssh-spain="ssh -i ~/.ssh/AWS-banketh-keys.pem ubuntu@52.40.42.115"
alias wubulubudubdub="sudo shutdown -h now"
alias f="fg"
alias mdv="mdv -t 597.208"
alias ffind="sudo find / -name"
alias open="xdg-open"

export GOPATH=$HOME/Developer/go/
export PATH=/usr/local/:$HOME/.scripts:$GOPATH:$PATH
export ZSH=/home/alvaro/.oh-my-zsh
export VIMRC=~/.vimrc
export ZSHRC=~/.zshrc
export GOSAN=~/Developer/go/src/github.com/san-lab/
export VISUAL=vim
export EDITOR="$VISUAL"

sshaws() {
  ssh -i ~/.ssh/AWS-IRELAND-2.pem -o "ServerAliveInterval=30" ec2-user@$@
}

scpaws() {
  scp -i ~/.ssh/AWS-IRELAND-2.pem $2 ec2-user@$1:$3
}

scpawsall() {
  scpaws aws-miner1 $1 $2 &
  scpaws aws-miner2 $1 $2 &
  scpaws aws-miner3 $1 $2 &
  scpaws aws-spain $1 $2 &
  scpaws aws-portugal $1 $2 &
  scpaws aws-uk $1 $2 &
}

ZSH_THEME="custom"

plugins=(git git-flow colored-man-pages zsh-completions chucknorris)

source $ZSH/oh-my-zsh.sh
alias l="ls -1"

source ${XDG_CONFIG_HOME:-$HOME/.config}/solarized/colors.ini
cat ~/.reminders.md

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder


# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
