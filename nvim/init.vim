" Install vim-plug automatically
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'gruvbox-community/gruvbox'
Plug 'itchyny/lightline.vim'
" External tools
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'yuki-ycino/fzf-preview.vim', { 'branch': 'release/remote', 'do': ':UpdateRemotePlugins' }
Plug 'francoiscabrol/ranger.vim'
Plug 'vimwiki/vimwiki'
Plug 'rbgrouleff/bclose.vim' " for ranger nested windows
Plug 'lingceng/z.vim'
Plug 'benmills/vimux'
Plug 'christoomey/vim-run-interactive'
" Editing
Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-speeddating'
Plug 'svermeulen/vim-yoink'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'svermeulen/vim-subversive'
Plug 'dhruvasagar/vim-zoom'
Plug 'mbbill/undotree'
Plug 'KabbAmine/vCoolor.vim'
" Git
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'rhysd/git-messenger.vim'
"Misc
Plug 'xolox/vim-misc'
Plug 'moll/vim-bbye'
Plug 'dhruvasagar/vim-table-mode'
Plug 'godlygeek/tabular'
" Lua
Plug 'svermeulen/vimpeccable'
Plug 'RishabhRD/popfix'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'vijaymarupudi/nvim-fzf'
" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'RishabhRD/nvim-lsputils'
Plug 'mfussenegger/nvim-jdtls'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'deoplete-plugins/deoplete-lsp'
Plug 'gfanto/fzf-lsp.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
call plug#end()

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
