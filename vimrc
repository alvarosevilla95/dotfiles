call plug#begin('~/.vim/plugged')
Plug 'daviesjamie/vim-base16-lightline'
Plug 'scrooloose/nerdTree'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-fugitive'
Plug 'easymotion/vim-easymotion'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'majutsushi/tagbar'
Plug 'jceb/vim-orgmode'
Plug 'tpope/vim-speeddating'
Plug 'rust-lang/rust.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'morhetz/gruvbox'
" Plug 'shinchu/lightline-gruvbox.vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'fatih/vim-go'
Plug 'liuchengxu/vista.vim'
" Plug 'ryanoasis/vim-devicons'
call plug#end()

" Colors
"let g:onedark_termcolors=16
syntax on
set background=dark
set t_Co=256
colorscheme gruvbox
let g:gruvbox_termcolors = 256

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
set autowrite

" easymotion
hi link EasyMotionTarget ErrorMsg
hi link EasyMotionShade Comment
hi link EasyMotionTarget2First Search
hi link EasyMotionTarget2Second Search

" Lightline config
function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction
function! NearestMethodOrFunction() abort
      return get(b:, 'vista_nearest_method_or_function', '')
endfunction
set statusline+=%{NearestMethodOrFunction()}
let g:lightline = {
            \ 'colorscheme': 'gruvbox',
            \ 'active': {
            \   'left':  [[ 'mode', 'paste' ], ['fugitive'], ['filename'], ['method']],
            \   'right': [['lineinfo'], ['percent'], ['filetype'], ['cocstatus']]
            \ },
            \ 'component_function': {
            \   'fugitive': 'LightlineFugitive',
            \   'modified': 'LightlineModified',
            \   'cocstatus': 'coc#status',
            \   'currentfunction': 'CocCurrentFunction',
            \   'method': 'NearestMethodOrFunction'
            \ }
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


" FZF / Ripgrep
let g:rg_command = '
            \ rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always"
            \ -g "*.{js,json,php,md,styl,jade,html,config,py,cpp,c,go,hs,rb,conf}"
            \ -g "!{.git,node_modules,vendor}/*" '

command! -bang -nargs=* F call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1, <bang>0)

" Coc autocomplete
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<Tab>" :
            \ coc#refresh()

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : 
            \"\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

inoremap <silent><expr> <TAB>
            \ pumvisible() ? coc#_select_confirm() :
            \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Snippets
let g:coc_snippet_next = '<tab>'
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" Vista
autocmd VimEnter * call vista#RunForNearestMethodOrFunction()
let g:vista_default_executive = 'coc'
let g:vista#renderer#enable_icon = 0
let g:vista#renderer#icons = {
\   "function": "\uf794",
\   "variable": "\uf71b",
\  }

" vim-go
let g:go_fmt_command = "goimports"

"
" Key bindings
"

" core remaps
nnoremap ; :
nnoremap : ;
nnoremap <C-L> :nohl<CR>
map Y y$
cmap w!! w !sudo tee > /dev/null %
let mapleader = "\<Space>"

" b -> buffer management
nnoremap <leader>bd :bd<CR>
nnoremap <leader>bn :bn<CR>
nnoremap <leader>bl :ls<CR>

" w -> window management
nnoremap <leader>ww <C-W><C-W>
nnoremap <leader>wl <C-W>l
nnoremap <leader>wk <C-W>k
nnoremap <leader>wj <C-W>j
nnoremap <leader>wh <C-W>h
nnoremap <leader>wd :q<CR>
nnoremap <leader>ws :sp<CR>
nnoremap <leader>wv :vsp<CR>
nnoremap <leader>wt <C-W><S-T>

" t  -> tab management
nnoremap <leader>tn :tabnew<CR>
nnoremap <leader>td :q<CR>
nnoremap <leader>tt :tabnext<CR>
nnoremap <leader>tT :tabprev<CR>

" f -> find (fzf)
nnoremap <leader>F :Files ~<CR>
nnoremap <leader>ff :Files .<CR>
nnoremap <leader>fg :Rg<CR>
nnoremap <leader>fm :Vista finder coc<CR>

" g -> git (fugutive)
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit -v -q<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gw :Gwrite<CR><CR>
nnoremap <leader>gr :Gread<CR>
nnoremap <leader>gb :Git branch<Space>
nnoremap <leader>go :Git checkout<Space>
nnoremap <leader>gps :Dispatch! git push<CR>
nnoremap <leader>gpl :Dispatch! git pull<CR>

" l -> language (coc)
nmap <leader>ln <Plug>(coc-rename)
nmap <leader>la <Plug>(coc-codeaction)
xmap <leader>la     <Plug>(coc-codeaction-selected)
nmap <leader>lq <Plug>(coc-fix-current)
nmap <leader>lr <Plug>(coc-references)
nmap <leader>li <Plug>(coc-implementation)
nmap <leader>ls <Plug>(coc-code-lens-action)
nmap <silent> gd <Plug>(coc-definition)
nmap K  :<C-u>call CocAction('doHover')<CR>

" Vista tagbar
nnoremap <leader>v  :Vista!! <CR>
