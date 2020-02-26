if has('nvim') && !exists('g:fzf_layout')
  autocmd! FileType fzf
  autocmd  FileType fzf set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
endif
let g:fzf_prefer_tmux = 0
let g:fzf_history_dir = '~/.local/share/fzf-history'

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --no-messages --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%', '?'),
  \   <bang>0)

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

function! s:buflist()
    redir => ls
    silent ls
    redir END
    return split(ls, '\n')
endfunction

function! s:bufopen(e)
    execute 'buffer' matchstr(a:e, '^[ 0-9]*')
endfunction

function! s:open_branch_fzf(line)
  let l:parser = split(a:line)
  let l:branch = l:parser[0]
  if l:branch ==? '*'
    let l:branch = l:parser[1]
  endif
  execute '!git checkout ' . l:branch
endfunction

command! -bang -nargs=0 GCheckout
  \ call fzf#vim#grep(
  \   'git branch -v', 0,
  \   {
  \     'sink': function('s:open_branch_fzf')
  \   },
  \   <bang>0
  \ )

command! -bang -nargs=0 GLog
  \ call fzf#vim#grep(
  \   'git log --graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@"', 0,
  \   {
  \     'sink': function('s:git_show_fzf')
  \   },
  \   <bang>0
  \ )

function! s:git_show_fzf(line)
  execute "grep -o '[a-f0-9]\{7\}' | git show --color=always " . a:line
endfunction

function! GetRegisters()
  redir => cout
  silent registers
  redir END
  return split(cout, "\n")[1:11]
endfunction

function! UseRegister(line)
  " let var_a = getreg(a:line[1], 1, 1)
  " let var_amode = getregtype(a:line[1])
  " call setreg('"', var_a, varamode)
  execute ':put ' a:line[1]
endfunction

command! Registers call fzf#run(fzf#wrap({
        \ 'source': GetRegisters(),
        \ 'sink': function('UseRegister')}))



