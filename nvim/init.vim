lua require('init')
source ~/dotfiles/nvim/colors.vim
source ~/dotfiles/nvim/maps.vim

function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

function! s:fnameescape(key, val)
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

" +set signcolumn=no
augroup active_view
  au!
  au BufEnter * :setlocal cursorline
  au WinEnter * :setlocal cursorline
  au BufLeave * :setlocal nocursorline
  au WinLeave * :setlocal nocursorline

  au BufEnter * :setlocal number relativenumber
  au WinEnter * :setlocal number relativenumber
  au BufLeave * :setlocal number norelativenumber
  au WinLeave * :setlocal number norelativenumber
augroup END
