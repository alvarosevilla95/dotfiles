" Install vim-plug automatically
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
" Plug 'morhetz/gruvbox'
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
" Plug 'liuchengxu/vista.vim'
" Plug 'janko/vim-test'
" Plug 'Shougo/neomru.vim'
" Language
" Plug 'arzg/vim-sh'
" Plug 'keith/swift.vim'
" Plug 'rust-lang/rust.vim'
" Plug 'uiiaoo/java-syntax.vim'
" Plug 'hdiniz/vim-gradle'
" Plug 'pangloss/vim-javascript'
" Plug 'leafgarland/typescript-vim' 
" Plug 'MaxMEllon/vim-jsx-pretty'
" Plug 'neovimhaskell/haskell-vim'
" Plug 'martinda/Jenkinsfile-vim-syntax'
" Plug 'derekwyatt/vim-scala'
" Lua
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

" Basic defaults
set background=dark
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

" augroup active_relative_number
"   au!
"   " au BufEnter * :setlocal signcolumn=yes
"   " au WinEnter * :setlocal signcolumn=yes
"   " au BufLeave * :setlocal signcolumn=no
"   " au WinLeave * :setlocal signcolumn=no
"   au BufEnter * :setlocal number relativenumber
"   au WinEnter * :setlocal number relativenumber
"   au BufLeave * :setlocal norelativenumber
"   au WinLeave * :setlocal norelativenumber
" augroup END

autocmd BufReadPost fugitive://* set bufhidden=delete
autocmd BufReadPost jdt://* set bufhidden=delete

augroup lsp
    au!
    au FileType java lua require('jdtls').start_or_attach({cmd = {'/Users/alvaro/dotfiles/bin/start-java-lsp.sh'}})
augroup end

autocmd FileType javascript,js,javascript.jsx,typescipt,typescriptreact setlocal shiftwidth=2 softtabstop=2 expandtab

let g:deoplete#enable_at_startup = 1
autocmd FileType TelescopePrompt call deoplete#custom#buffer_option('auto_complete', v:false)

let g:ranger_map_keys = 0
let g:netrw_liststyle = 3

" Test
let test#java#runner = 'gradletest'
let test#strategy = "vimux"

" Ultisnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

let g:python3_host_prog = "/Users/alvaro/.pyenv/shims/python"

let g:lightline = {
            \ 'tabline': {
            \   'left': [['tabs']],
            \   'right': [['']]
            \ },
            \ 'colorscheme': 'gruvbox',
            \ 'active': {
            \   'left':  [[ 'mode', 'paste' ], ['fugitive'], ['filename']],
            \   'right': [['lineinfo'], ['percent'], ['filetype']]
            \ },
            \ 'component_function': {
            \   'fugitive': 'FugitiveHead',
            \ }
            \ }

" vimwiki
let wiki_1 = {}
let wiki_1.path = '/Users/alvaro/Dropbox/wiki/'
let wiki_1.syntax = 'markdown'
let wiki_1.ext = '.md'
let g:vimwiki_global_ext = 0
let g:vimwiki_list = [wiki_1]
let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}

source ~/dotfiles/nvim/fzf.vim
source ~/dotfiles/nvim/maps.vim
source ~/dotfiles/nvim/colors.vim

lua require('config')
lua require'lspconfig'.gopls.setup{}
lua require'lspconfig'.tsserver.setup{}
lua require'lspconfig'.vimls.setup{}
lua require'lspconfig'.pyright.setup{}
