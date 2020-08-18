alias vimrc="vim ~/.config/nvim/init.vim"
alias zshrc="vim ~/.zshrc"

alias auth="gimme-aws-creds <<< 0"

alias r="ranger"
alias v="nvim"
alias vi="nvim"
alias vim="nvim"
alias vimw='vim -c "VimwikiIndex"'
alias vw='vim -c "VimwikiIndex"'
alias ls="exa"
alias ll="exa -lF"
alias la="exa -alF"

alias f='fzf_z'
alias fs='ftsession'
alias fr='fzf_rg'
alias fl="fzf_git_log"
alias glog="fzf_git_log"
alias flr="fzf_git_reflog"
alias fa='fzf_git_add'
alias fb='fzf_git_checkout'
alias fk='fzf_kill'
alias fw='f=$(fd --type f  . ~/Dropbox/wiki | fzf --preview="bat {} --theme="gruvbox" --color=always --style=\"numbers\"") && vim $f'
alias fj='f=$(fzf_dates 365  | awk "{print \$1}" ) && vim ~/Dropbox/wiki/diary/$f.md'
alias fJ='f=$(fzf_dates 365 forward | awk "{print \$1}" ) && vim ~/Dropbox/wiki/diary/$f.md'

function tmux_attach_create(){
    tmux a -t $1 2>/dev/null || tmux new -s $1 2>/dev/null || tmux new -s $1 -d
}
alias t="tmux_attach_create"
alias tm="tmux_attach_create main"
alias tw="tmux_attach_create wiki"
alias ts="tmux_attach_create ibsuite"

alias ds='f=$(fd --type f  . ~/dotfiles | fzf --preview="bat {} --theme="gruvbox" --color=always --style=\"numbers\"") && vim $f'

function e() {
    f=$(fd --type f  . $1 | fzf --preview="bat {} --theme="gruvbox" --color=always --style=\"numbers\"") && vim $f
}

function snipe() {
    file=~/dotfiles/bin/$1
    if [ ! -f $file ]; then
        echo "#!/bin/sh\nset -eo pipefail\n" > $file
        chmod +x $file
    fi
    vim -c "set filetype=sh" $file
}

bwcopy() {
    if hash bw 2>/dev/null; then
        bw get item "$(bw list items | jq '.[] | "\(.name) | username: \(.login.username) | id: \(.id)" ' | fzf | awk '{print $(NF -0)}' | sed 's/\"//g')" | jq '.login.password' | sed 's/\"//g' | pbcopy
    fi
}
alias fp="bwcopy"

alias gfl="git fuzzy log"
alias gfs="git fuzzy status"

alias k="kubectl"
alias kx="kubectx -"
alias kl="kubectl logs"
alias kc="kconfig"


alias ql='quick-look'
alias pman='man-preview'
# cdf - cd to current Finder window. pfd for echo. pfs echo Finder selection

alias ydl='youtube-dl -f best'
