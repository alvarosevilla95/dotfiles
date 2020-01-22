colorscheme gruvbox
let g:gruvbox_termcolors = 256
highlight SignColumn guibg=bg
highlight SignColumn ctermbg=bg
highlight GitGutterAdd    guifg=#009900 guibg=bg ctermfg=2 ctermbg=bg
highlight GitGutterChange guifg=#bbbb00 guibg=bg ctermfg=3 ctermbg=bg
highlight GitGutterDelete guifg=#ff2222 guibg=bg ctermfg=1 ctermbg=bg
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
