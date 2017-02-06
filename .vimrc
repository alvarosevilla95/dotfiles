call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdTree'

" Plug 'tpope/vim-surround'
" Plug 'easymotion/vim-easymotion'
" Plug 'tpope/vim-fugitive'

" Plug 'msanders/snipmate.vim'
" Plug 'scrooloose/syntastic'

" Plug 'ehamberg/vim-cute-python'
" Plug 'tikhomirov/vim-glsl'
Plug 'pangloss/vim-javascript'
Plug 'fatih/vim-go'
Plug 'tomlion/vim-solidity'
Plug 'leafgarland/typescript-vim'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'chriskempson/base16-vim'

" Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
" Plug 'zerowidth/vim-copy-as-rtf'
call plug#end()
set background=dark
if file_readable(expand("~/.vimrc_background"))
    let base16colorspace=256
    source ~/.vimrc_background
endif
syntax on
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
set mouse=a
set number
set notimeout ttimeout ttimeoutlen=200
set pastetoggle=<F11>
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
map Y y$
nnoremap <C-L> :nohl<CR><C-L> 
nnoremap ; :
nnoremap : ;
set clipboard=unnamed
set noshowmode
let g:airline_theme='base16'
let g:airline_left_sep=''
let g:airline_right_sep='' 
let g:airline_powerline_fonts = 0
let g:airline#extensions#whitespace#enabled = 0
let g:airline_section_x = airline#section#create([])
let g:airline_section_y = airline#section#create_right(['%Y'])
let g:airline_section_z = airline#section#create(['windowswap', '%3p%%'.g:airline_symbols.space, 'linenr', ':%-2v '])
