if $BC == 'light'
    set background=light
    au BufEnter * hi Visual guifg=#fbf1c7 guibg=#af3a03 gui=none " simple orange visual
    au BufEnter * hi TelescopePreviewLine guibg=#ebdbb2
    au BufEnter * hi TelescopeSelection guibg=#ebdbb2
else
    set background=dark
    au BufEnter * hi Visual guifg=#282828 guibg=#fe8019 gui=none " simple orange visual
    au BufEnter * hi TelescopePreviewLine guibg=#3c3836
    au BufEnter * hi TelescopeSelection guibg=#3c3836
    au BufEnter * hi Pmenu guibg=#282828
    au BufEnter * hi TabLine guibg=#1d2021
    au BufEnter * hi TabLineSel guibg=#1d2021 guifg=#ebdbb2
    au BufEnter * hi TabLineFill guibg=#1d2021
endif
au BufEnter * hi SignColumn guibg=bg gui=none 
au BufEnter * hi GruvboxRedSign ctermfg=167 ctermbg=237 guifg=#fb4934 guibg=bg
au BufEnter * hi GruvboxYellowSign ctermfg=214 ctermbg=237 guifg=#fabd2f guibg=bg
au BufEnter * hi GruvboxBlueSign ctermfg=167 ctermbg=237 guifg=#83a598  guibg=bg
au BufEnter * hi GruvboxAquaSign ctermfg=167 ctermbg=237 guifg=#8ec07c guibg=bg
au ColorScheme * lua require'nvim-web-devicons'.setup()
let g:gruvbox_contrast_dark = "hard"
let g:gruvbox_contrast_light = "medium"
colorscheme gruvbox

lua require('init')
source ~/dotfiles/nvim/maps.vim
source ~/dotfiles/nvim/tabline.vim

function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

func s:fnameescape(key, val)
  return fnameescape(a:val)
endfunc

function! s:build_arglist(lines)
  execute 'args ' . join(map(a:lines, function('s:fnameescape')), ' ') 
endfunction

function! s:copy_results(lines)
  let joined_lines = join(a:lines, " ")
  " if len(a:lines) > 1
  "   let joined_lines .= "\n"
  " endif
  let @+ = joined_lines
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-l': function('s:build_arglist'),
  \ 'ctrl-g': function('s:copy_results'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }
