" Install vim-plug automatically
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'morhetz/gruvbox'
" Plug 'gruvbox-community/gruvbox'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'
Plug 'benmills/vimux'
Plug 'vimwiki/vimwiki'
Plug 'liuchengxu/vista.vim'
Plug 'rust-lang/rust.vim'
Plug 'fatih/vim-go'
Plug 'janko/vim-test'
Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-speeddating'
Plug 'svermeulen/vim-yoink'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'svermeulen/vim-subversive'
Plug 'xolox/vim-misc'
Plug 'keith/swift.vim'
Plug 'mattn/calendar-vim'
Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim' " for ranger nested windows
Plug 'dhruvasagar/vim-zoom'
Plug 'martinda/Jenkinsfile-vim-syntax'
Plug 'ryanoasis/vim-devicons'
Plug 'moll/vim-bbye'
Plug 'dhruvasagar/vim-table-mode'
Plug 'rbgrouleff/bclose.vim'
Plug 'godlygeek/tabular'
Plug 'hdiniz/vim-gradle'
Plug 'yuki-ycino/fzf-preview.vim', { 'branch': 'release/remote', 'do': ':UpdateRemotePlugins' }
Plug 'mbbill/undotree'
Plug 'christoomey/vim-run-interactive'
Plug 'Shougo/neomru.vim'
Plug 'tpope/vim-obsession'
Plug 'neovimhaskell/haskell-vim'
Plug 'uiiaoo/java-syntax.vim'
Plug 'arzg/vim-sh'
Plug 'mipmip/vim-scimark'
Plug 'rhysd/git-messenger.vim'
Plug 'lifepillar/vim-gruvbox8'
Plug 'derekwyatt/vim-scala'
Plug 'KabbAmine/vCoolor.vim'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim' 
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'neovimhaskell/haskell-vim'
Plug 'lingceng/z.vim'
Plug 'neovim/nvim-lspconfig'
Plug 'mfussenegger/nvim-jdtls'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'deoplete-plugins/deoplete-lsp'
Plug 'gfanto/fzf-lsp.nvim'
Plug 'vijaymarupudi/nvim-fzf'
Plug 'RishabhRD/nvim-lsputils'
call plug#end()


autocmd BufReadPost fugitive://* set bufhidden=delete
autocmd BufReadPost jdt://* set bufhidden=delete

" Basic defaults
syntax on
set background=dark
if $LIGHT_MODE
    set background=light
endif
set updatetime=100
set splitright
set cursorline
set relativenumber
set hidden
set wildmenu
set showcmd
set hlsearch
set ignorecase
set smartcase
set backspace=indent,eol,start
set autoindent
set nostartofline
set ruler
set laststatus=2
set confirm
set visualbell
set mouse=a
set number
set notimeout ttimeout ttimeoutlen=0
set pastetoggle=<F11>
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set clipboard=unnamed
set noshowmode
set autowrite
set wildmode=longest,full
set foldlevel=2
" set undofile
" set undodir=~/.config/nvim/undodir

set signcolumn=no
set shortmess=I
augroup active_relative_number
  au!
  " au BufEnter * :setlocal signcolumn=yes
  " au WinEnter * :setlocal signcolumn=yes
  " au BufLeave * :setlocal signcolumn=no
  " au WinLeave * :setlocal signcolumn=no
  au BufEnter * :setlocal number relativenumber
  au WinEnter * :setlocal number relativenumber
  au BufLeave * :setlocal nonumber norelativenumber
  au WinLeave * :setlocal nonumber norelativenumber
augroup END

let g:LanguageClient_serverCommands = {
    \ 'java': ['/usr/local/bin/jdtls', '-data', getcwd()],
    \ }

let g:gitgutter_map_keys = 0

let g:prosession_dir = "~/.local/share/nvim/sessions"
let g:startify_session_dir= "~/.local/share/nvim/sessions"
let g:startify_change_to_dir=0
let g:animate#duration = 200.0

let g:ranger_map_keys = 0
let g:netrw_liststyle = 3

" Test
let test#java#runner = 'gradletest'
let test#strategy = "vimux"

" Ultisnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:coc_snippet_next = '<tab>'

let g:java_highlight_all = 1 

" GitGutter
let g:gitgutter_override_sign_column_highlight = 1

" Vista
" autocmd VimEnter * call vista#RunForNearestMethodOrFunction()
let g:vista_default_executive = 'coc'
let g:vista#renderer#enable_icon = 0
let g:vista#renderer#icons = {
\   "function": "\uf794",
\   "variable": "\uf71b",
\  }

" vim-go
let g:go_fmt_command = "goimports"

let g:lightline = {
            \ 'tabline': {
            \   'left': [['tabs']],
            \   'right': [['']]
            \ },
            \ 'colorscheme': 'gruvbox',
            \ 'active': {
            \   'left':  [[ 'mode', 'paste' ], ['fugitive'], ['filename']],
            \   'right': [['lineinfo'], ['percent'], ['filetype'], ['cocstatus']]
            \ },
            \ 'component_function': {
            \   'fugitive': 'FugitiveHead',
            \   'cocstatus': 'StatusDiagnostic',
            \ }
            \ }

source ~/dotfiles/nvim/fzf.vim
source ~/dotfiles/nvim/maps.vim
source ~/dotfiles/nvim/colors.vim

let wiki_1 = {}
let wiki_1.path = '/Users/alvaro/Dropbox/wiki/'
let wiki_1.syntax = 'markdown'
let wiki_1.ext = '.md'
let g:vimwiki_global_ext = 0

let g:vimwiki_list = [wiki_1]
let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}

let g:haskell_classic_highlighting = 1

let g:fzf_preview_fzf_color_option = ''
augroup fzf_preview
  autocmd!
  autocmd User fzf_preview#initialized call s:fzf_preview_settings()
augroup END
function! s:fzf_preview_settings() abort
  let g:fzf_preview_command = 'COLORTERM=truecolor ' . g:fzf_preview_command
  let g:fzf_preview_grep_preview_cmd = 'COLORTERM=truecolor ' . g:fzf_preview_grep_preview_cmd
endfunction
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9, 'highlight': 'Comment' } }

let g:python3_host_prog = "/Users/alvaro/.pyenv/shims/python"

autocmd FileType javascript,js,javascript.jsx,typescipt,typescriptreact setlocal shiftwidth=2 softtabstop=2 expandtab

if has('nvim-0.5')
  augroup lsp
    au!
    au FileType java lua require('jdtls').start_or_attach({cmd = {'/Users/alvaro/dotfiles/bin/start-java-lsp.sh'}})
  augroup end
endif

let g:deoplete#enable_at_startup = 1

