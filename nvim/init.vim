lua require('config')

autocmd FileType java lua require('jdtls').start_or_attach({cmd = {'/Users/alvaro/dotfiles/bin/start-java-lsp.sh'}})
autocmd FileType javascript,js,javascript.jsx,typescipt,typescriptreact setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd BufReadPost fugitive://* set bufhidden=delete
autocmd BufReadPost jdt://* set bufhidden=delete
autocmd FileType TelescopePrompt call deoplete#custom#buffer_option('auto_complete', v:false)

" Colors
hi Visual  guifg=#282828 guibg=#fe8019 gui=none " simple orange visual
highlight Search guifg=#282828 guibg=#fe8019 gui=none " simple orange visual
highlight IncSearch guifg=#282828 guibg=#fabd2f gui=none " simple orange visual
highlight SignColumn guibg=bg
highlight SignColumn ctermbg=bg

" FZF
" TODO: fix colors when using fzf from packer

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

function! RipgrepFzf(dir, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, '"" ' . a:dir)
  let reload_command = printf(command_fmt, '{q} ' . a:dir)
  let spec = {'options': ['--phony', '--query', "", '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction
command! -bang -nargs=? -complete=dir Rg call RipgrepFzf(<q-args>, <bang>0)
command! -nargs=* -complete=dir Cd call fzf#run(fzf#wrap(
  \ {'source': 'fd . '.(empty(<f-args>) ? '.' : <f-args>).' --type=d 2>/dev/null',
  \  'sink': 'cd'}))
command! -nargs=0 Cdz call fzf#run(fzf#wrap(
  \ {'source': 'cat ~/.z | cut -d "|" -f1',
  \  'sink': 'cd'}))

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

source ~/dotfiles/nvim/maps.vim
