if $BC == 'light'
    set background=light
else
    set background=dark
endif
lua require('init')

" highlight Visual  guifg=#282828 guibg=#fe8019 gui=none " simple orange visual

source ~/dotfiles/nvim/maps.vim
