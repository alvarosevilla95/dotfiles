call plug#begin('~/.vim/plugged')
Plug 'chriskempson/base16-vim'
Plug 'daviesjamie/vim-base16-lightline'
Plug 'fatih/vim-go'
Plug 'tomlion/vim-solidity'
Plug 'scrooloose/nerdTree'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-fugitive'
"Plug 'maralla/completor.vim'
Plug 'easymotion/vim-easymotion'
Plug 'scrooloose/syntastic'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'majutsushi/tagbar'
Plug 'jceb/vim-orgmode'
Plug 'tpope/vim-speeddating'
call plug#end()

" Colors
"let g:onedark_termcolors=16
syntax on
set background=dark
set t_Co=256
let base16colorspace=256
source ~/.vimrc_background

" Basic defaults
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

" Some convenient mappings
let mapleader = "\<Space>"
map Y y$
nnoremap <C-L> :nohl<CR>
" nnoremap <C-L> :nohl<CR><C-L> 
nnoremap ; :
nnoremap : ;
nnoremap <C-p> :FZF<CR>

" fugitive git bindings
" nnoremap <leader>ga :Git add %:p<CR><CR>
nnoremap <leader>gs :Gstatus<CR>
autocmd FileType go nnoremap <leader>gi :GoImports<CR>
" nnoremap <leader>gc :Gcommit -v -q<CR>
" nnoremap <leader>gt :Gcommit -v -q %:p<CR>
" nnoremap <leader>gd :Gdiff<CR>
" nnoremap <leader>ge :Gedit<CR>
" nnoremap <leader>gr :Gread<CR>
" nnoremap <leader>gw :Gwrite<CR><CR>
" nnoremap <leader>gl :silent! Glog<CR>:bot copen<CR>
" nnoremap <leader>gp :Ggrep<Space>
" nnoremap <leader>gm :Gmove<Space>
" nnoremap <leader>gb :Git branch<Space>
" nnoremap <leader>go :Git checkout<Space>
" nnoremap <leader>gps :Dispatch! git push<CR>
" nnoremap <leader>gpl :Dispatch! git pull<CR>

" other leader keybindings
"nnoremap <leader>a :bn<CR>
nnoremap <leader>bd :bd<CR>
nnoremap <leader>bn :bn<CR>
nnoremap <leader>bl :ls<CR>

nnoremap <leader>ww <C-W><C-W>
nnoremap <leader>wl <C-W>l
nnoremap <leader>wk <C-W>k
nnoremap <leader>wj <C-W>j
nnoremap <leader>wh <C-W>h
nnoremap <leader>wd :bd<CR>
nnoremap <leader>wt <C-W><S-T>

nnoremap <leader>wt <C-W><S-T>

nnoremap <leader>t :tabnew<CR>

" vim-go mappings
autocmd FileType go nmap <leader>b  <Plug>(go-build)
autocmd FileType go nmap <leader>r  <Plug>(go-run)
nnoremap <C-n> :cnext<CR>
nnoremap <leader>p :Files ~<CR>
nnoremap <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>
let g:go_fmt_command = "goimports"
let g:go_addtags_transform = "camelcase"
" let g:go_highlight_types = 1
" let g:go_highlight_fields = 1
" let g:go_highlight_functions = 1
" let g:go_highlight_methods = 1
" let g:go_highlight_operators = 1
" let g:go_highlight_extra_types = 1

" automatically save on GoBuild
set autowrite

" tee magic for when sudo write is needed
cmap w!! w !sudo tee > /dev/null %

" Javascript stuff
let g:jsx_ext_required = 0 " Allow JSX in normal JS files
let g:javascript_opfirst = 1

" Completor shenanigans
let g:completor_gocode_binary = '/home/alvaro/go/bin/gocode'
let g:completor_node_binary = '/usr/bin/node'
let g:completor_auto_trigger = 1
inoremap <expr> \<C-n> pumvisible() ? "\<C-n>" : "\<C-n>\<C-n>"
let g:godef_split=1
hi link EasyMotionTarget ErrorMsg
hi link EasyMotionShade Comment
hi link EasyMotionTarget2First Search
hi link EasyMotionTarget2Second Search

" Lightline config
let g:lightline = {
    \ 'colorscheme': 'base16',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'filename', 'fugitive', 'modified' ] ]
    \ },
    \ 'component_function': {
    \   'fugitive': 'LightlineFugitive',
    \   'modified': 'LightlineModified'
    \ },
    \ }
function! LightlineModified()
if &filetype == "help"
  return ""
elseif &modified
  return "+"
elseif &modifiable
  return ""
else
  return ""
endif
endfunction
function! LightlineFugitive()
return exists('*fugitive#head') ? fugitive#head() : ''
endfunction

let g:rg_command = '
  \ rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always"
  \ -g "*.{js,json,php,md,styl,jade,html,config,py,cpp,c,go,hs,rb,conf}"
  \ -g "!{.git,node_modules,vendor}/*" '

command! -bang -nargs=* F call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1, <bang>0)
