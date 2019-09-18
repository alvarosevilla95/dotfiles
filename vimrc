call plug#begin('~/.vim/plugged')
Plug 'daviesjamie/vim-base16-lightline'
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
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'fatih/vim-go'
Plug 'liuchengxu/vista.vim'
Plug 'tpope/vim-vinegar'
Plug 'xolox/vim-misc'
Plug 'tpope/vim-commentary'
Plug 'vimwiki/vimwiki'
Plug 'janko/vim-test'
Plug 'benmills/vimux'
call plug#end()

let test#java#runner = 'gradletest'
let test#strategy = "vimux"

" Colors
"let g:onedark_termcolors=16
syntax on
set background=dark
set t_Co=256
colorscheme gruvbox
let g:gruvbox_termcolors = 256

" let g:netrw_winsize = 20
let g:netrw_liststyle = 3
" let g:netrw_browse_split = 4
" nmap <buffer> - <Plug>VinegarUp


" Basic defaults
" set splitright
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
" set foldmethod=indent

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
"
" command! -bang -nargs=* RgDev
"   \ call fzf#vim#grep(
"   \   'rg <q-args> /Users/alvaro/ --column --line-number --no-heading --color=always' 
"   \  , 1,
"   \   <bang>0 ? fzf#vim#with_preview('up:60%')
"   \           : fzf#vim#with_preview('right:50%:hidden', '?'),
"   \   <bang>0)

" let g:rg_command = 'rg --files --hidden --smartcase --glob "!{.git,node_modules,vendor, .swp}"'
" command! -bang -nargs=* F call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1, <bang>0)
"
function! s:buflist()
    redir => ls
    silent ls
    redir END
    return split(ls, '\n')
endfunction

function! s:bufopen(e)
    execute 'buffer' matchstr(a:e, '^[ 0-9]*')
endfunction

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
" autocmd VimEnter * call vista#RunForNearestMethodOrFunction()
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
nnoremap <leader>d :bd<CR>
nnoremap <leader>bn :bn<CR>
nnoremap <leader>bl :ls<CR>

" w -> window management
nnoremap <leader>ss <C-W><C-W>
nnoremap <leader>sv :vsp<CR>
nnoremap <leader>sV :sp<CR>
nnoremap <leader>st :tabnew<CR>
nnoremap <leader>sT <C-W><S-T>

" f -> find (fzf)
nnoremap <leader>fF :Files ~<CR>
nnoremap <leader>ff :Files .<CR>
nnoremap <leader>fg :Rg<CR>
nnoremap <leader>fG :RgDev<CR>
nnoremap <leader>fm :Vista finder coc<CR>
nnoremap <silent> <Leader>fb :call fzf#run({
            \   'source':  reverse(<sid>buflist()),
            \   'sink':    function('<sid>bufopen'),
            \   'options': '+m',
            \   'down':    len(<sid>buflist()) + 2
            \ })<CR>



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
nmap <leader>ll <Plug>(coc-codeaction)
xmap <leader>ll     <Plug>(coc-codeaction-selected)
nmap <leader>lf <Plug>(coc-fix-current)
nmap <leader>lr <Plug>(coc-references)
nmap <leader>li <Plug>(coc-implementation)
nmap <leader>ls <Plug>(coc-code-lens-action)
nmap <silent> gd <Plug>(coc-definition)
nnoremap <silent> gd :call CocAction('jumpDefinition', 'drop') <CR>
nnoremap K  :<C-u>call CocAction('doHover')<CR>

" Vista tagbar
nnoremap <leader>v  :Vista!! <CR>

" t -> Tests
nnoremap <leader>tn :TestNearest<CR>
nnoremap <leader>tf :TestFile<CR>
nnoremap <leader>ts :TestSuite<CR>
nnoremap <leader>tl :TestLast<CR>
" nmap <silent> tg TestVisit<CR>
