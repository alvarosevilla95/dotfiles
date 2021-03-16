if $BC == 'light'
    set background=light
    au BufEnter * highlight Visual guifg=#fbf1c7 guibg=#af3a03 gui=none " simple orange visual
else
    set background=dark
    au BufEnter * highlight Visual guifg=#282828 guibg=#fe8019 gui=none " simple orange visual
endif
au BufEnter * highlight SignColumn guibg=bg gui=none 
au BufEnter * hi GruvboxRedSign ctermfg=167 ctermbg=237 guifg=#fb4934 guibg=bg
au BufEnter * hi GruvboxYellowSign ctermfg=214 ctermbg=237 guifg=#fabd2f guibg=bg
au BufEnter * hi GruvboxBlueSign ctermfg=167 ctermbg=237 guifg=#83a598  guibg=bg
au BufEnter * hi GruvboxAquaSign ctermfg=167 ctermbg=237 guifg=#8ec07c guibg=bg

lua require('init')


source ~/dotfiles/nvim/maps.vim

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

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-l': function('s:build_arglist'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }
