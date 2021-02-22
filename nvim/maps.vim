onoremap ie :exec "normal! ggVG"<cr>
cnoremap <c-A> <Home>
cnoremap <c-k> <c-p>
cnoremap <c-j> <c-n>
cmap w!! w !sudo tee > /dev/null %
nnoremap <C-L> :nohl<CR>
map Y y$
nmap s <plug>(SubversiveSubstitute)
xmap s <plug>(SubversiveSubstitute)
nmap ss :%s::g<Left><Left>
" nmap ss <plug>(SubversiveSubstituteLine)
inoremap <expr> <C-j> pumvisible() ? "\<C-N>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-P>" : "\<C-k>"
nnoremap _ :Ranger<CR>
" nnoremap gl <Plug>VimwikiFollowLink<CR>

let mapleader = "\<Space>"
" nnoremap <leader>l :nohl
nnoremap <leader>- <C-^>
nnoremap <leader>j <C-W>j
nnoremap <leader>k <C-W>k
nnoremap <leader>l <C-W>l
nnoremap <leader>h <C-W>h
nnoremap <leader>J <C-W>J
nnoremap <leader>K <C-W>K
nnoremap <leader>L <C-W>L
nnoremap <leader>H <C-W>H
nnoremap <leader>[ gt
nnoremap <leader>] gT
nnoremap <leader>dd :Bdelete<CR>
nnoremap <leader>dD :bufdo bwipeout<CR>
nnoremap <leader>z :tabe %<CR>
nnoremap <leader>u :UndotreeToggle<CR>
vnoremap <leader>= :'<,'> Tabularize /

nnoremap <leader>ww :topleft sp ~/Dropbox/wiki/index.md<CR>
nnoremap <leader>wW :VimwikiIndex

" r -> run
nnoremap <leader>rr :r! 
nnoremap <leader>rR :! 
nnoremap <leader>ri :RunInInteractiveShell<space>

" f -> find (fzf)
inoremap <expr> <plug>(fzf-complete-path) fzf#vim#complete#path("fd . --color=never")
imap <c-x><c-f> <plug>(fzf-complete-path)
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)
nnoremap <silent>  <leader>; :Commands<CR>
nnoremap <silent> <Leader>fh :History<CR>
nnoremap <silent> <leader>ds :Files ~/dotfiles/<CR>
nnoremap <silent> <leader>ff :Files .<CR>
nnoremap <leader>fF :Files 
nnoremap <silent> <leader>f~ :Files ~<CR>
nnoremap <silent> <Leader>f. :Files <C-r>=expand("%:h")<CR>/<CR>
nnoremap <silent> <leader>fw :Files ~/Dropbox/wiki/<CR>
nnoremap <silent> <leader>fs :<C-u>FzfPreviewGitStatus -processors=g:fzf_preview_fugitive_processors<CR>
nnoremap <silent> <leader>fq :FzfPreviewQuickFix<CR>
nnoremap <silent> <leader>fg :Cdz<CR>
nnoremap <silent> <leader>fG :Cd .<CR>
nnoremap <silent> <leader>fc :FzfPreviewGitBranches<CR>
nnoremap <silent> <Leader>fb :Buffers<CR>

" s -> search
nnoremap <silent> <leader>ss :Rg<CR>
nnoremap <silent> <leader>sd :Rg ~/dotfiles<CR>
nnoremap <silent> <leader>sw :Rg ~/Dropbox/wiki/<CR>
nnoremap <leader>sg :Google 
nnoremap <silent> <leader>se :UltiSnipsEdit<CR>

" g -> git (fugutive)
nnoremap <leader>gg :FzfPreviewGitActions<CR>
nnoremap <leader>ge :Gedit<Space>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gS :Git show<CR>
nnoremap <leader>gw :Gwrite<CR><CR>
nnoremap <leader>gc :Git commit -v -q<CR>
nnoremap <leader>gC :Git commit -v -q --amend<CR>
nnoremap <leader>gd :Gdiffsplit!<CR>
nnoremap <leader>gD :Git diff<CR>
nnoremap <leader>gr :Grebase --interactive<Space>
nnoremap <leader>gR :Grebase<Space>
nnoremap <leader>go :Git checkout<Space>
nnoremap <leader>gO :Git branch<Space>
nnoremap <leader>gl :FzfPreviewGitLogs<CR>
nnoremap <leader>gL :0Glog<CR>
nnoremap <leader>gpp :Git push<CR>
nnoremap <leader>gpP :Git pull<CR>
nnoremap <leader>gbm :Gblame<CR>
nnoremap <leader>gbb :.Gbrowse!<CR>
vnoremap <leader>gbb :Gbrowse!<CR>
nnoremap <leader>gbB :.Gbrowse<CR>
vnoremap <leader>gbB :Gbrowse<CR>
nmap <Leader>gk <Plug>(git-messenger)
" get diff from left / right buffer in 3 way diff
nnoremap dgh :diffget //2<CR> 
nnoremap dgl :diffget //3<CR> 
nnoremap <leader>gpdd :Git diff master...<CR> 
nnoremap <leader>gpdf :Gdiff master...:%<CR> 

" c -> lsp
imap <expr> <cr>  pumvisible() ? complete_info()["selected"] != "-1" ?  "\<Plug>(completion_confirm_completion)"  : "\<c-n>\<CR>" :  "\<CR>"
nnoremap <silent> gd :lua vim.lsp.buf.definition()<CR>
nnoremap <silent> KK  :lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD :lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> [d :lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> ]d :lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap <leader>cr :References<CR>
nnoremap <leader>ci :Implementations<CR>
nnoremap <leader>ce :Diagnostics<CR>
nnoremap <leader>fm :WorkspaceSymbols<CR>
nnoremap <leader>fM :DocumentSymbols<CR>
nnoremap <leader>cn :lua vim.lsp.buf.rename()<CR>
nnoremap <leader>cf :lua vim.lsp.buf.formatting()<CR>
vnoremap <leader>cf :lua vim.lsp.buf.range_formatting()<CR>
nnoremap <leader>cc :lua vim.lsp.buf.code_action()<CR>

au FileType java nnoremap <leader>cc :lua require('jdtls').code_action()<CR>
au FileType java vnoremap <leader>cc <Esc><Cmd>lua require('jdtls').code_action(true)<CR>
au FileType java nnoremap <leader>cN <Cmd>lua require('jdtls').code_action(false, 'refactor')<CR>
" au FileType java command! -buffer JdtCompile lua require('jdtls').compile()
" au FileType java command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()
" au FileType java command! -buffer JdtJol lua require('jdtls').jol()
" au FileType java command! -buffer JdtBytecode lua require('jdtls').javap()
" au FileType java command! -buffer JdtJshell lua require('jdtls').jshell()
" au FileType java nnoremap <leader>df <Cmd>lua require'jdtls'.test_class()<CR>
" au FileType java nnoremap <leader>dn <Cmd>lua require'jdtls'.test_nearest_method()<CR>
"
nnoremap <leader>co :VimuxRunCommand('python -i ' . bufname("%"))<CR>
nnoremap <leader>cb :VimuxRunCommand('./gradlew build -x integrationtest')<CR>

" motion
nnoremap [or :source ~/.config/nvim/init.vim<CR>
