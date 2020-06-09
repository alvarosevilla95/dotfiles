onoremap ie :exec "normal! ggVG"<cr>
nnoremap ; :
nnoremap : ;
xnoremap ; :
xnoremap : :normal 
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
nmap S <plug>(SubversiveSubstituteToEndOfLine)
inoremap <expr> <C-j> pumvisible() ? "\<C-N>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-P>" : "\<C-k>"
nnoremap - :Ranger<CR>
" nnoremap gl <Plug>VimwikiFollowLink<CR>

" inoremap <expr> <c-x><c-l> fzf#vim#complete(fzf#wrap({
"   \ 'prefix': '^.*$',
"   \ 'source': 'rg -n ^ --color always --no-messages',
"   \ 'options': '--ansi --delimiter : --nth 3..',
"   \ 'reducer': { lines -> join(split(lines[0], ':\zs')[2:], '') }}))

let mapleader = "\<Space>"
nnoremap <leader>- <C-^>
nnoremap <leader>j <C-W>w
nnoremap <leader>k <C-W>W
nnoremap <leader>l gt
nnoremap <leader>h gT
nnoremap <leader>dd :Bdelete<CR>
nnoremap <leader>dD :bufdo bwipeout<CR>
nnoremap <leader>m :TableModeToggle<CR>
nnoremap <leader>z :tabe %<CR>
nnoremap <leader>u :UndotreeToggle<CR>
xnoremap <leader>n :normal <CR>
nnoremap <leader>o :Obsess  ~/.local/share/nvim/sessions/
nnoremap <leader>O :Obsess!<CR>
" r -> run
nnoremap <leader>rr :r! 
nnoremap <leader>rR :! 
nnoremap <leader>ri :RunInInteractiveShell<space>

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
imap <c-f> <plug>(fzf-complete-path)
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)
nnoremap <leader>; :Commands<CR>
nnoremap <leader>/ :FzfPreviewLines<CR>
nnoremap <leader>? :Lines<CR>
nnoremap <leader>ds :Files ~/dotfiles/<CR>
nnoremap <leader>fa :FzfPreviewMru<CR>
nnoremap <leader>ff :Files .<CR>
nnoremap <leader>fF :Files 
nnoremap <leader>f~ :Files ~<CR>
nnoremap <leader>fw :Files ~/Dropbox/wiki/<CR>
nnoremap <leader>fd :DiarySearch<CR>
nnoremap <leader>fD :DiarySearch forward<CR>
nnoremap <leader>fs :<C-u>FzfPreviewGitStatus -processors=g:fzf_preview_fugitive_processors<CR>
nnoremap <leader>fS :FzfPreviewChanges<CR>
nnoremap <leader>fq :FzfPreviewQuickFix<CR>
nnoremap <leader>fj :FzfPreviewJumps<CR>
nnoremap <leader>fn :Maps<CR>
nnoremap <leader>fg :Rg<CR>
nnoremap <leader>fG :Rg 
nnoremap <leader>fm :CocFzfList outline<CR>
nnoremap <leader>fc :GCheckout<CR>
nnoremap <leader>fe :CocList diagnostics<CR>
nnoremap <silent> <Leader>fb :FzfPreviewBuffers<CR>

" s -> search
nnoremap <leader>se :UltiSnipsEdit<CR>
nnoremap <leader>ss :Rg<CR>
nnoremap <leader>sS :Rg!<CR>
nnoremap <leader>sd :Rg ~/dotfiles<CR>
nnoremap <leader>sw :Rg ~/Dropbox/wiki/<CR>

" g -> git (fugutive)
nnoremap <leader>gg :Git<Space>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gw :Gwrite<CR><CR>
nnoremap <leader>gc :Gcommit -v -q<CR>
nnoremap <leader>gC :Gcommit -v -q --amend<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gD :Git diff<CR>
nnoremap <leader>gr :Grebase --interactive<Space>
nnoremap <leader>gR :Grebase<Space>
nnoremap <leader>gb :Gblame<CR>
nnoremap <leader>go :Git checkout<Space>
nnoremap <leader>gO :Git branch<Space>
nnoremap <leader>gl :Commits<CR>
nnoremap <leader>gL :BCommits<CR>
nnoremap <leader>gpp :Git push<CR>
nnoremap <leader>gpP :Git pull<CR>
nnoremap <Leader>gB :.Gbrowse<CR>
vnoremap <Leader>gB :Gbrowse<CR>

" c -> coc
nnoremap <leader>cb :VimuxRunCommand('./gradlew build')<CR>
nmap <leader>cn <Plug>(coc-rename)
nnoremap <leader>cc :CocAction<CR>
xnoremap <leader>cc :CocAction<CR>
nnoremap <leader>ce :CocList diagnostics<CR>
nmap <leader>cf <Plug>(coc-fix-current)
nmap <leader>cr <Plug>(coc-references)
nmap <leader>ci <Plug>(coc-implementation)
nmap <leader>cs <Plug>(coc-code-lens-action)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gD <Plug>(coc-type-definition)
nnoremap <silent> gd :call CocAction('jumpDefinition', 'drop') <CR>
nnoremap K  :<C-u>call CocAction('doHover')<CR>
" Remap for do codeAction of selected region
function! s:cocActionsOpenFromSelected(type) abort
  execute 'CocCommand actions.open ' . a:type
endfunction
nnoremap <silent> <leader>ca :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@
xnoremap <silent> <leader>ca :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>


" Vista tagbar
nnoremap <leader>v  :Vista!! <CR>

" t -> Tests
nnoremap <leader>tn :TestNearest<CR>
nnoremap <leader>tf :TestFile<CR>
nnoremap <leader>ts :TestSuite<CR>
nnoremap <leader>tl :TestLast<CR>

