" Install vim-plug automatically
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin()
" Plug 'daviesjamie/vim-base16-lightline'
Plug 'morhetz/gruvbox'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'
Plug 'benmills/vimux'
Plug 'vimwiki/vimwiki'
Plug 'tpope/vim-vinegar'
Plug 'liuchengxu/vista.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
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
Plug 'airblade/vim-gitgutter'
Plug 'svermeulen/vim-subversive'
Plug 'xolox/vim-misc'
" Plug 'tpope/vim-sensible'
" Plug 'tpope/vim-eunuch'
call plug#end()

" Basic defaults
syntax on
set background=dark
set t_Co=256
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
set t_vb=
set t_ut=
" set ttymouse=xterm2
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

let g:ranger_map_keys = 0
let g:netrw_liststyle = 3

" Test
let test#java#runner = 'gradletest'
let test#strategy = "vimux"

" Ultisnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
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

source ~/dotfiles/nvim/fzf.vim
source ~/dotfiles/nvim/coc.vim
source ~/dotfiles/nvim/lightline.vim
source ~/dotfiles/nvim/maps.vim
source ~/dotfiles/nvim/colors.vim
