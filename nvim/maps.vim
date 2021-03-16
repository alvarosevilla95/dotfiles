onoremap ie :exec "normal! ggVG"<cr>
cnoremap <c-a> <Home>
cnoremap <c-k> <c-p>
cnoremap <c-j> <c-n>
cnoremap <c-d> <c-r>=expand('')<Left><Left>
inoremap <c-d> <c-r>=expand('')<Left><Left>

" cmap w!! w !sudo tee > /dev/null %
nnoremap <C-F> :<C-F>?
nnoremap <C-L> :nohl<CR>
map Y y$
nmap s <plug>(SubversiveSubstitute)
xmap s <plug>(SubversiveSubstitute)
nmap ss :s//g<Left><Left>
nmap sg :silent grep 
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
nnoremap <leader>[ gT
nnoremap <leader>] gt
nnoremap <leader>dd :Bdelete<CR>
nnoremap <leader>dD :Bdelete!<CR>
nnoremap <leader>da :bufdo bwipeout<CR>
nnoremap <leader>dn :enew<CR>
nnoremap <leader>z :tabe %<CR>
vnoremap <leader>= :'<,'> Tabularize /

nnoremap <leader>ww :topleft sp ~/Dropbox/wiki/index.md<CR>
nnoremap <leader>wW :VimwikiIndex<CR>
au FileType vimwiki nmap <expr> <CR> pumvisible() ? complete_info()["selected"] != "-1" ?  "\<Plug>(completion_confirm_completion)"  : "\<c-n>\<CR>" : "\<Plug>VimwikiFollowLink"
au FileType vimwiki xmap <CR> <Plug>VimwikiNormalizeLinkVisualCR

" r -> run
nnoremap <leader>r<space> :!<space>
nnoremap <leader>R<space> :r!<space>
nnoremap <leader>rlf :luafile %<CR>
nnoremap <leader>rs :source $DOTFILES/nvim/init.vim<CR>

" f -> find (fzf)
nnoremap <silent> <leader>ff :Files .<CR>
nnoremap <silent> <leader>fd :Files ~/dotfiles/<CR>
nnoremap <silent> <leader>f~ :Files ~<CR>
nnoremap <silent> <Leader>f. :Files %:h<CR>
nnoremap <silent> <leader>fw :Files ~/Dropbox/wiki/<CR>
nnoremap <leader>f<Space> :Files<Space>
nnoremap <silent> <Leader>fb :Buffers<CR>
inoremap <expr> <plug>(fzf-complete-path) fzf#vim#complete#path("fd . --color=never")
imap <c-x><c-f> <plug>(fzf-complete-path)
nnoremap <silent>  <leader>; :Commands<CR>

nnoremap <leader>cg :Gcd<CR>
nnoremap <leader>cl :lcd %:h<CR>
nnoremap <leader>cf :Cdz<CR>
nnoremap <leader>ch :cd ~<CR>
nnoremap <leader>c. :Cd .<CR>
nnoremap <leader>c<space> :Cd<space>

nnoremap <silent> <Leader>qo :copen<CR>
nnoremap <silent> <Leader>qc :cclose<CR>

" s -> search
nnoremap <silent> <leader>ss :Rg<CR>
nnoremap <silent> <leader>sd :Rg ~/dotfiles<CR>
nnoremap <silent> <leader>sw :Rg ~/Dropbox/wiki/<CR>
lnoremap <silent> <leader>se :UltiSnipsEdit<CR>

" g -> git (fugutive)
nnoremap <leader>G :Gedit :<CR>
nnoremap <leader>gg :Gedit :<CR>
nnoremap <leader>ge :Gedit<Space>
nnoremap <leader>gs :Gsplit<Space>
nnoremap <leader>gd :Gdiffsplit!<CR>
nnoremap <leader>gD :Git diff<CR>
nnoremap <leader>gl :GV<CR>
nnoremap <leader>gL :0Glog<CR>
nnoremap <leader>gbm :Gblame<CR>
nnoremap <leader>gB :Gbrowse 
nnoremap <leader>gbb :Gbrowse %<CR>
vnoremap <leader>gbb :Gbrowse<CR>
nnoremap <leader>gbB :Gbrowse! %<CR>
vnoremap <leader>gbB :Gbrowse!<CR>
nnoremap <leader>gpdd :Git diff master...<CR> 
nnoremap <leader>gpdf :Gdiff master...:%<CR> 
nmap KG <Plug>(git-messenger)

" completion
inoremap <silent><expr> <Tab> compe#complete()
inoremap <silent><expr> <CR>  compe#confirm('<CR>')
inoremap <silent><expr> <C-e> compe#close('<C-e>')
inoremap <silent><expr> <C-f> compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d> compe#scroll({ 'delta': -4 })
" lsp
nnoremap <silent> gd :lua vim.lsp.buf.definition()<CR>
nnoremap <silent> KK  :lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD :lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> [d :lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> ]d :lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap <leader>ir :References<CR>
nnoremap <leader>iR :Implementations<CR>
nnoremap <leader>ie :Diagnostics<CR>
nnoremap <leader>im :WorkspaceSymbols<CR>
nnoremap <leader>iM :DocumentSymbols<CR>
nnoremap <leader>in :lua vim.lsp.buf.rename()<CR>
nnoremap <leader>if :lua vim.lsp.buf.formatting()<CR>
vnoremap <leader>if :lua vim.lsp.buf.range_formatting()<CR>
nnoremap <leader>ii :lua vim.lsp.buf.code_action()<CR>
nnoremap <leader>Ib :lua require'dap'.toggle_breakpoint()<CR>
nnoremap <leader>IB :lua require'dap'.list_breakpoints()<CR>
nnoremap <leader>II :lua require'dap'.continue()<CR>
nnoremap <leader>IO :lua require'dap'.step_into()<CR>
nnoremap <leader>Io :lua require'dap'.step_over()<CR>
nnoremap <leader>IU :lua require'dap'.step_out()<CR>
nnoremap <leader>Ir :lua require'dap'.repl.open()<CR>
nnoremap <leader>Iq :lua require'dap'.stop()<CR>
nnoremap Kd :lua require'dap.ui.variables'.hover()<CR>
nnoremap KD :lua require'dap.ui.variables'.scopes()<CR>
nnoremap KE :lua vim.lsp.diagnostic.show_line_diagnostics()<CR>

au FileType java nnoremap <leader>ii :lua require('jdtls').code_action()<CR>
au FileType java vnoremap <leader>ii <Esc><Cmd>lua require('jdtls').code_action(true)<CR>
au FileType java nnoremap <leader>iN <Cmd>lua require('jdtls').code_action(false, 'refactor')<CR>
au FileType java nnoremap <leader>Ic <Cmd>lua require'jdtls'.test_class()<CR>
au FileType java nnoremap <leader>Im <Cmd>lua require'jdtls'.test_nearest_method()<CR>

au FileType python nnoremap <leader>Im <Cmd>lua require'dap-python'.test_method()<CR>
au FileType python vnoremap <leader>Is <Esc>:lua require'dap-python'.debug_selection()<CR>

" nnoremap <leader>co :VimuxRunCommand('python -i ' . bufname("%"))<CR>
" nnoremap <leader>cb :VimuxRunCommands'./gradlew build -x integrationtest')<CR>

nnoremap <Leader>` :call ToggleSignColumn()<CR>
function! ToggleSignColumn()
    if !exists("b:signcolumn_on") || !b:signcolumn_on
        set signcolumn=yes
        let b:signcolumn_on=1
    else
        set signcolumn=no
        let b:signcolumn_on=0
    endif
endfunction

