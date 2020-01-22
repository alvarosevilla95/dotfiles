onoremap ie :exec "normal! ggVG"<cr>
nnoremap ; :
nnoremap : ;
nnoremap <C-L> :nohl<CR>
nnoremap [{ :GitGutterPrevHunk<CR>
nnoremap ]} :GitGutterNextHunk<CR>
map Y y$
cmap w!! w !sudo tee > /dev/null %
nmap <c-n> <plug>(YoinkPostPasteSwapBack)
nmap <c-p> <plug>(YoinkPostPasteSwapForward)
nmap p <plug>(YoinkPaste_p)
nmap P <plug>(YoinkPaste_P)
nmap s <plug>(SubversiveSubstitute)
nmap ss <plug>(SubversiveSubstituteLine)
nmap S <plug>(SubversiveSubstituteToEndOfLine)

let mapleader = "\<Space>"
nnoremap <leader>- <C-^>
nnoremap <leader>k gt
nnoremap <leader>j gT
nnoremap <leader>d :bd<CR>
nnoremap <leader>D :bufdo bwipeout<CR>


" s -> substitute
nmap <leader>s <plug>(SubversiveSubstituteRange)
xmap <leader>s <plug>(SubversiveSubstituteRange)
nmap <leader>ss <plug>(SubversiveSubstituteWordRange)
nmap <leader>S <plug>(SubversiveSubstituteRangeConfirm)
nmap <leader>SS <plug>(SubversiveSubstituteWordRangeConfirm)
nnoremap <leader>p :Reg<CR>

" f -> find (fzf)
nnoremap <leader>; :History:<CR>
nnoremap <leader>ff :Files .<CR>
nnoremap <leader>fF :Files ~<CR>
nnoremap <leader>fg :Rg<CR>
nnoremap <leader>fG :Rg!<CR>
nnoremap <leader>fm :Vista finder coc<CR>
nnoremap <silent> <Leader>fb :call fzf#run({
            \   'source':  reverse(<sid>buflist()),
            \   'sink':    function('<sid>bufopen'),
            \   'options': '+m',
            \   'down':    len(<sid>buflist()) + 2
            \ })<CR>

" g -> git (fugutive)
nnoremap <leader>gg :Git<Space>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <Leader>ga :GitGutterStageHunk<CR>
nnoremap <Leader>gu :GitGutterUndoHunk<CR>
nnoremap <leader>gw :Gwrite<CR><CR>
nnoremap <leader>gcc :Gcommit -v -q<CR>
nnoremap <leader>gca :Gcommit -v -q --amend<CR>
nnoremap <leader>gco :GCheckout<CR>
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
nnoremap <Leader>gj :GitGutterNextHunk<CR>
nnoremap <Leader>gk :GitGutterPrevHunk<CR>
nnoremap <Leader>gB :.Gbrowse<CR>
vnoremap <Leader>gB :Gbrowse<CR>

" l -> language (coc)
nnoremap <leader>lb :VimuxRunCommand('./gradlew build')<CR>
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

