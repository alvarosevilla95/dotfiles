onoremap ie :exec "normal! ggVG"<cr>
" nnoremap ; :
" nnoremap : ;
" xnoremap ; :
" xnoremap : :normal 
cnoremap <c-A> <Home>
cnoremap <c-f> <c-f>?
cnoremap <c-k> <c-p>
cnoremap <c-j> <c-n>
nnoremap <C-L> :nohl<CR>
" nnoremap [{ :GitGutterPrevHunk<CR>
" nnoremap ]} :GitGutterNextHunk<CR>
map Y y$
cmap w!! w !sudo tee > /dev/null %
nmap <c-n> <plug>(YoinkPostPasteSwapBack)
nmap <c-p> <plug>(YoinkPostPasteSwapForward)
nmap p <plug>(YoinkPaste_p)
nmap P <plug>(YoinkPaste_P)
nmap s <plug>(SubversiveSubstitute)
nmap ss <plug>(SubversiveSubstituteLine)
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
nnoremap <leader>L gt
nnoremap <leader>H gT
nnoremap <leader>dd :Bdelete<CR>
nnoremap <leader>dD :bufdo bwipeout<CR>
nnoremap <leader>m :TableModeToggle<CR>
nnoremap <leader>z :tabe %<CR>
nnoremap <leader>u :UndotreeToggle<CR>
xnoremap <leader>n :normal <CR>
nnoremap <leader>o <C-W>o
vnoremap <leader>= :'<,'> Tabularize /

" nnoremap <leader>O :Obsess!<CR>
" r -> run
nnoremap <leader>rr :r! 
nnoremap <leader>rR :! 
nnoremap <leader>ri :RunInInteractiveShell<space>

" nnoremap <leader>hc :VCoolor<CR>


" q -> quit
nnoremap <leader>q :close<CR>

" w -> wiki
nnoremap <leader>wf :Files ~/Dropbox/wiki/<CR>
nnoremap <leader>wF :Files ~/Dropbox/wiki/diary<CR>
nmap <Leader>wS <Plug>VimwikiUISelect
nnoremap <leader>ws :VimwikiSearch<CR>
nmap <Leader>wy <Plug>VimwikiMakeTomorrowDiaryNote
nmap <Leader>wY <Plug>VimwikiMakeYesterdayDiaryNote
nnoremap <leader>wc :Calendar<CR>

" " s -> substitute
" nmap <leader>s <plug>(SubversiveSubstituteRange)
" xmap <leader>s <plug>(SubversiveSubstituteRange)
" nmap <leader>ss <plug>(SubversiveSubstituteWordRange)
" nmap <leader>S <plug>(SubversiveSubstituteRangeConfirm)
" nmap <leader>SS <plug>(SubversiveSubstituteWordRangeConfirm)
" nnoremap <leader>p :Reg<CR>

" f -> find (fzf)
inoremap <expr> <plug>(fzf-complete-path) fzf#vim#complete#path("fd . --color=never")
inoremap <expr> <plug>(fzf-complete-file)  fzf#vim#complete#path("fd --type f . --color=never")
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)
imap <c-f> <plug>(fzf-complete-path)
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)
nnoremap <leader>; :Commands<CR>
nnoremap <leader>/ :FzfPreviewLines<CR>
nnoremap <leader>? :Lines<CR>
nnoremap <leader>ds :Files ~/dotfiles/<CR>
nnoremap <leader>fa :FzfPreviewMru<CR>
nnoremap <silent> <leader>ff :Files .<CR>
nnoremap <leader>fF :Files 
nnoremap <silent> <leader>f~ :Files ~<CR>
nnoremap <silent> <Leader>f. :Files <C-r>=expand("%:h")<CR>/<CR>
nnoremap <silent> <Leader>fh :History<CR>
nnoremap <leader>fw :Files ~/Dropbox/wiki/<CR>
nnoremap <leader>fs :<C-u>FzfPreviewGitStatus -processors=g:fzf_preview_fugitive_processors<CR>
nnoremap <leader>fS :FzfPreviewChanges<CR>
nnoremap <leader>fq :FzfPreviewQuickFix<CR>
nnoremap <leader>fj :FzfPreviewJumps<CR>
nnoremap <leader>fn :Maps<CR>
nnoremap <leader>fg :Cdz<CR>
nnoremap <leader>fG :Cd .<CR>
nnoremap <leader>fc :FzfPreviewGitBranches<CR>
nnoremap <silent> <Leader>fb :Buffers<CR>
nnoremap <leader>fz :Cdz<CR>
nnoremap <leader>fd :Cd .<CR>

" s -> search
nnoremap <leader>se :UltiSnipsEdit<CR>
nnoremap <leader>ss :Rg<CR>
nnoremap <leader>sS :Rg!<CR>
nnoremap <leader>sd :Rg ~/dotfiles<CR>
nnoremap <leader>sw :Rg ~/Dropbox/wiki/<CR>

" g -> git (fugutive)
nnoremap <leader>gg :FzfPreviewGitActions<CR>
nnoremap <leader>ge :Gedit<Space>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gS :Git show<CR>
nnoremap <leader>gw :Gwrite<CR><CR>
nnoremap <leader>gc :Gcommit -v -q<CR>
nnoremap <leader>gC :Gcommit -v -q --amend<CR>
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


let g:git_messenger_no_default_mappings=v:true

" c -> lsp
nnoremap <leader>cr :References<CR>
nnoremap <leader>ci :Implementations<CR>
nnoremap <leader>ce :Diagnostics<CR>
nnoremap <leader>fm :DocumentSymbols<CR>
nnoremap <leader>fM :WorkspaceSymbols<CR>
nnoremap <silent> gd :lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD :lua vim.lsp.buf.type_definition()<CR>
nnoremap <leader>cn :lua vim.lsp.buf.rename()<CR>
nnoremap K  :lua vim.lsp.buf.hover()<CR>
nnoremap <silent> [d :lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> ]d :lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap <leader>cf :lua vim.lsp.buf.formatting()<CR>
vnoremap <leader>cf :lua vim.lsp.buf.range_formatting()<CR>
nnoremap <leader>cc :CodeActions<CR>
vnoremap <leader>cc :RangeCodeActions<CR>
nnoremap <leader>co :VimuxRunCommand('python -i ' . bufname("%"))<CR>
nnoremap <leader>cb :VimuxRunCommand('./gradlew build -x integrationtest')<CR>
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

" t -> Tests
nnoremap <leader>tn :TestNearest<CR>
nnoremap <leader>tf :TestFile<CR>
nnoremap <leader>ts :TestSuite<CR>
nnoremap <leader>tl :TestLast<CR>

" tnoremap <Esc> <C-\><C-n>
