if $BC == 'light'
    set background=light
    au BufEnter * hi Visual guifg=#fbf1c7 guibg=#af3a03 gui=none " simple orange visual
    au BufEnter * hi TelescopePreviewLine guibg=#ebdbb2
    au BufEnter * hi TelescopeSelection guibg=#ebdbb2
    au BufEnter * hi TabLine gui=none guibg=#ebdbb2 guifg=#bdae93
    au BufEnter * hi TabLineSel guibg=#ebdbb2 guifg=#3c3836
    au BufEnter * hi TabLineFill guibg=#ebdbb2
else
    set background=dark
    " au BufEnter * hi Visual guifg=#282828 guibg=#fe8019 gui=none " simple orange visual
    au BufEnter * hi Visual guifg=#ebdbb2 guibg=#cc241d gui=none
    au BufEnter * hi TelescopePreviewLine guibg=#3c3836
    au BufEnter * hi TelescopeSelection guibg=#3c3836
    au BufEnter * hi Pmenu guibg=#282828
    " au BufEnter * hi PmenuSel guibg=#b8bb26
    au BufEnter * hi PmenuSel guibg=#fb4934 guifg=#fbf1c7
    au BufEnter * hi CompeDocumentation guibg=#282828
    au BufEnter * hi TabLine gui=none guibg=bg guifg=#665c54
    au BufEnter * hi TabLineSel guibg=bg guifg=#ebdbb2
    au BufEnter * hi TabLineFill guibg=bg
endif
au BufEnter * hi SignColumn guibg=bg gui=none 
au BufEnter * hi GruvboxRedSign ctermfg=167 ctermbg=237 guifg=#fb4934 guibg=bg
au BufEnter * hi GruvboxYellowSign ctermfg=214 ctermbg=237 guifg=#fabd2f guibg=bg
au BufEnter * hi GruvboxBlueSign ctermfg=167 ctermbg=237 guifg=#83a598  guibg=bg
au BufEnter * hi GruvboxAquaSign ctermfg=167 ctermbg=237 guifg=#8ec07c guibg=bg
let g:gruvbox_contrast_dark = "hard"
let g:gruvbox_contrast_light = "medium"
colorscheme gruvbox
