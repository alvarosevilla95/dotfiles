alias vimrc="vim ~/.config/nvim/init.vim"
alias zshrc="vim ~/.zshrc"

alias r="ranger"
alias v="nvim"
alias vi="nvim"
alias vim="nvim"
alias vimw='vim -c "VimwikiIndex"'
alias vims='vim -S'
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
alias fw='f=$(fd --type f  . ~/Dropbox/wiki | fzf --preview="bat {} --color=always --style=\"numbers\"") && vim $f'
alias fj='f=$(fzf_dates 365  | awk "{print \$1}" ) && vim ~/Dropbox/wiki/diary/$f.md'
alias fJ='f=$(fzf_dates 365 forward | awk "{print \$1}" ) && vim ~/Dropbox/wiki/diary/$f.md'

function tmux_attach_create(){
    tmux a -t $1 2>/dev/null || tmux new -s $1 2>/dev/null || tmux new -s $1 -d
}
alias t="tmux_attach_create"
alias tm="tmux_attach_create main"
alias tw="tmux_attach_create wiki"
alias ts="tmux_attach_create ibsuite"

alias ds='f=$(fd --type f  . ~/dotfiles | fzf --preview="bat {} --color=always --style=\"numbers\"") && vim $f'

function e() {
    f=$(fd --type f  . $1 | fzf --preview="bat {} --color=always --style=\"numbers\"") && vim $f
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

function auth() {
    yes 0 | awsAuth ${1:-$AWS_PROFILE} 
}
compdef _aws_complete_profiles auth

alias ts='tools'

function toggle_colors() {
    if [[ "$BC" = "dark" ]]; then
        cat ~/dotfiles/arch/alacritty.yml ~/dotfiles/arch/alacritty-light.yml > ~/.alacritty.yml
        cat ~/dotfiles/tmux/tmux-light-colors.conf ~/dotfiles/tmux/tmux.conf > ~/.tmux.conf
        gsed -i 's:BC=dark:BC=light:' ~/dotfiles/zsh/colors.zsh
        gsed -i 's:BAT_THEME=gruvbox:BAT_THEME=gruvbox-light:' ~/dotfiles/zsh/colors.zsh
        gsed -i 's:gruvbox:gruvbox-light:' ~/.gitconfig
        # tmux source-file ~/.tmux.conf
    fi
    if [[ "$BC" = "light" ]]; then
        cat ~/dotfiles/arch/alacritty.yml ~/dotfiles/arch/alacritty-dark.yml > ~/.alacritty.yml
        cat ~/dotfiles/tmux/tmux-dark-colors.conf ~/dotfiles/tmux/tmux.conf > ~/.tmux.conf
        gsed -i 's:BC=light:BC=dark:' ~/dotfiles/zsh/colors.zsh
        gsed -i 's:BAT_THEME=gruvbox-light:BAT_THEME=gruvbox:' ~/dotfiles/zsh/colors.zsh
        gsed -i 's:gruvbox-light:gruvbox:' ~/.gitconfig
        gsed -i 's:BAT_THEME=gruvbox-light$:BAT_THEME=gruvbox:' ~/dotfiles/zsh/colors.zsh
        # tmux source-file ~/.tmux.conf
    fi
    source ~/dotfiles/zsh/colors.zsh
    source ~/dotfiles/zsh/fzf.zsh
}
alias tc="toggle_colors"
