function toggle_colors() {
    if [[ "$BC" = "dark" ]]; then
        cat ~/dotfiles/arch/alacritty.yml ~/dotfiles/arch/alacritty-light.yml > ~/.alacritty.yml
        cat ~/dotfiles/tmux/tmux-light-colors.conf ~/dotfiles/tmux/tmux.conf > ~/.tmux.conf
        gsed -i 's:BC=dark:BC=light:' ~/dotfiles/zsh/colors.zsh
        gsed -i 's:BAT_THEME=gruvbox-dark:BAT_THEME=gruvbox-light:' ~/dotfiles/zsh/colors.zsh
        gsed -i 's:gruvbox:gruvbox-light:' ~/.gitconfig
        gsed -i "s:theme\ =\ 'gruvbox':theme\ =\ 'gruvbox_light':" ~/dotfiles/nvim/lua/plugins.lua
    fi
    if [[ "$BC" = "light" ]]; then
        cat ~/dotfiles/arch/alacritty.yml ~/dotfiles/arch/alacritty-dark.yml > ~/.alacritty.yml
        cat ~/dotfiles/tmux/tmux-dark-colors.conf ~/dotfiles/tmux/tmux.conf > ~/.tmux.conf
        gsed -i 's:BC=light:BC=dark:' ~/dotfiles/zsh/colors.zsh
        gsed -i 's:BAT_THEME=gruvbox-light:BAT_THEME=gruvbox-dark:' ~/dotfiles/zsh/colors.zsh
        gsed -i 's:gruvbox-light:gruvbox:' ~/.gitconfig
        gsed -i 's:BAT_THEME=gruvbox-light$:BAT_THEME=gruvbox-dark:' ~/dotfiles/zsh/colors.zsh
        gsed -i "s:theme\ =\ 'gruvbox_light':theme\ =\ 'gruvbox':" ~/dotfiles/nvim/lua/plugins.lua
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

function snipe() {
    file=~/dotfiles/bin/$1
    if [ ! -f $file ]; then
        echo "#!/bin/sh\nset -eo pipefail\n" > $file
        chmod +x $file
    fi
    nvrttc "set filetype=sh" $file
}

function fixSwitchSd() {
    sudo chflags -R arch /Volumes/Switch
    sudo dot_clean -mn /Volumes/Switch
}
