if has('nvim') && !exists('g:fzf_layout')
  autocmd! FileType fzf
  autocmd  FileType fzf set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
endif

let g:fzf_prefer_tmux = 0
let g:fzf_history_dir = '~/.local/share/fzf-history'

let g:fzf_preview_use_floating_window = 0
let g:fzf_preview_layout = 'below split new'

augroup fzf_preview
  autocmd!
  autocmd User fzf_preview#initialized call s:fzf_preview_settings()
augroup END

function! s:fugitive_add(paths) abort
  for path in a:paths
    execute 'silent G add ' . path
  endfor
  echomsg 'Git add ' . join(a:paths, ', ')
endfunction

function! s:fugitive_reset(paths) abort
  for path in a:paths
    execute 'silent G reset ' . path
  endfor
  echomsg 'Git reset ' . join(a:paths, ', ')
endfunction

function! s:fugitive_patch(paths) abort
  for path in a:paths
    execute 'silent tabedit ' . path . ' | silent Gdiff'
  endfor
  echomsg 'Git add --patch ' . join(a:paths, ', ')
endfunction

function! s:fzf_preview_settings() abort
  let g:fzf_preview_fugitive_processors = fzf_preview#resource_processor#get_processors()
  let g:fzf_preview_fugitive_processors['ctrl-a'] = function('s:fugitive_add')
  let g:fzf_preview_fugitive_processors['ctrl-r'] = function('s:fugitive_reset')
  let g:fzf_preview_fugitive_processors['ctrl-c'] = function('s:fugitive_patch')
endfunction


function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --no-messages --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%', '?'),
  \   <bang>0)

function! RipgrepFzf(dir, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, '"" ' . a:dir)
  let reload_command = printf(command_fmt, '{q} ' . a:dir)
  let spec = {'options': ['--phony', '--query', "", '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -bang -nargs=? -complete=dir Rg call RipgrepFzf(<q-args>, <bang>0)

command! -bang -nargs=* VimwikiSearch
  \ call fzf#vim#grep(
  \   'rg --no-messages --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>). ' ~/Dropbox/wiki/' , 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%', '?'),
  \   <bang>0)

function! s:date_line_handler(l)
  let keys = split(a:l, ' ')
  exec 'e' '~/Dropbox/wiki/diary/' . keys[0] . '.md'
endfunction

command! -nargs=* -bang DiarySearch call fzf#run(fzf#wrap({'source': 'dates 365 ' . <q-args>, 'sink': function('<sid>date_line_handler')}, <bang>0)) 

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



