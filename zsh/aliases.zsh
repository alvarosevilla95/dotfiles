alias vimrc="vim ~/.config/nvim/init.vim"
alias zshrc="vim ~/.zshrc"

compdef _vim nvr
alias v="nvr"
alias vs="vim -S"
alias v="nvim"
alias vi="nvim"
alias vim="nvim"
alias vims='vim -S'

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

function toggle_colors() {
    if [[ "$BC" = "dark" ]]; then
        cat ~/dotfiles/arch/alacritty.yml ~/dotfiles/arch/alacritty-light.yml > ~/.alacritty.yml
        cat ~/dotfiles/tmux/tmux-light-colors.conf ~/dotfiles/tmux/tmux.conf > ~/.tmux.conf
        gsed -i 's:BC=dark:BC=light:' ~/dotfiles/zsh/colors.zsh
        gsed -i 's:BAT_THEME=gruvbox-dark:BAT_THEME=gruvbox-light:' ~/dotfiles/zsh/colors.zsh
        gsed -i 's:gruvbox:gruvbox-light:' ~/.gitconfig
        gsed -i "s:theme\ =\ 'gruvbox':theme\ =\ 'gruvbox_light':" ~/dotfiles/nvim/lua/options.lua
        # tmux source-file ~/.tmux.conf
    fi
    if [[ "$BC" = "light" ]]; then
        cat ~/dotfiles/arch/alacritty.yml ~/dotfiles/arch/alacritty-dark.yml > ~/.alacritty.yml
        cat ~/dotfiles/tmux/tmux-dark-colors.conf ~/dotfiles/tmux/tmux.conf > ~/.tmux.conf
        gsed -i 's:BC=light:BC=dark:' ~/dotfiles/zsh/colors.zsh
        gsed -i 's:BAT_THEME=gruvbox-light:BAT_THEME=gruvbox-dark:' ~/dotfiles/zsh/colors.zsh
        gsed -i 's:gruvbox-light:gruvbox:' ~/.gitconfig
        gsed -i 's:BAT_THEME=gruvbox-light$:BAT_THEME=gruvbox-dark:' ~/dotfiles/zsh/colors.zsh
        gsed -i "s:theme\ =\ 'gruvbox_light':theme\ =\ 'gruvbox':" ~/dotfiles/nvim/lua/options.lua
        # tmux source-file ~/.tmux.conf
    fi
    source ~/dotfiles/zsh/colors.zsh
    source ~/dotfiles/zsh/fzf.zsh
}

function stail() {
    local a=$(echo $1 | sed 's.^scp://..')
    local h=$(echo $a | cut -d / -f 1)
    local p=$(echo $a | cut -d / -f 2-)
    ssh $h tail -f \~/$p
}
compdef _vim stail

function snipe() {
    file=~/dotfiles/bin/$1
    if [ ! -f $file ]; then
        echo "#!/bin/sh\nset -eo pipefail\n" > $file
        chmod +x $file
    fi
    vim -c "set filetype=sh" $file
}

