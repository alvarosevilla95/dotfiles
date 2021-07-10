onoremap ie :exec "normal! ggVG"<cr>
cnoremap <c-a> <Home>
cmap <c-k> <c-p>
cmap <c-j> <c-n>
cmap <c-h> <Left>
cmap <c-l> <Right>
cnoremap <c-s> <c-r>=luaeval('')<Left><Left>
inoremap <c-s> <c-r>=luaeval('')<Left><Left>
cnoremap <c-d> <c-r>=expand('')<Left><Left>
inoremap <c-d> <c-r>=expand('')<Left><Left>
tnoremap <Esc> <C-\><C-n>
tnoremap <C-\><C-n> <Esc>
au FileType fzf tnoremap <buffer> <Esc> <Esc>
au FileType fzf tnoremap <buffer> <C-\><C-n> <C-\><C-n>
nnoremap <C-F> :<C-F>?
nnoremap <silent> <C-L> :nohl<CR>
map Y y$
nmap s <plug>(SubversiveSubstitute)
xmap s <plug>(SubversiveSubstitute)
nmap ss :s:::g<Left><Left><Left>
nmap sv :s:\v::g<Left><Left><Left>
nmap sS :S::<Left>
nmap sg :silent grep 
inoremap <expr> <C-j> pumvisible() ? "\<C-N>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-P>" : "\<C-k>"
nnoremap _ :Ranger<CR>
nnoremap <Up> <Up><Up><Up><Up><Up>
nnoremap <Down> <Down><Down><Down><Down><Down>
nnoremap <Left> <Left><Left><Left><Left><Left>
nnoremap <Right> <Right><Right><Right><Right><Right>
nnoremap gx :execute '!open ' . shellescape(expand('<cWORD>'), 1)<cr>
vnoremap gx :<c-u>execute '!open ' . shellescape(@*)<cr>

let mapleader = "\<Space>"
" nnoremap - :e %:h<CR>
nnoremap - :lua require'telescope.builtin'.file_browser({ cwd = '%:h'})<CR>
nnoremap <leader>. :<Up><CR>
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
nnoremap [t gT
nnoremap ]t gt
nnoremap <leader>dd :Bdelete<CR>
nnoremap <leader>dD :bwipeout<CR>
nnoremap <silent><leader>da :bufdo silent bwipeout<CR>
nnoremap <leader>dn :enew<CR>
nnoremap <leader>z :tabe %<CR>
vnoremap <leader>= :'<,'> Tabularize /

nnoremap <leader>bd :bd<CR>
nnoremap <leader>bD :bd!<CR>
nnoremap <leader>bw :bw<CR>
nnoremap <leader>bW :bw!<CR>

nnoremap <leader>wo <C-W>o
" nnoremap <leader>ww :VimwikiIndex<CR>
" au FileType vimwiki nmap <expr> <CR> pumvisible() ? complete_info()["selected"] != "-1" ?  "\<Plug>(completion_confirm_completion)"  : "\<c-n>\<CR>" : "\<Plug>VimwikiFollowLink"
" au FileType vimwiki xmap <CR> <Plug>VimwikiNormalizeLinkVisualCR

" r -> run
nnoremap <leader>r<space> :!<space>
nnoremap <leader>R<space> :r!<space>
nnoremap <leader>rlf :luafile %<CR>
nnoremap <leader>rss :source $DOTFILES/nvim/init.vim<CR>
nnoremap <leader>rsf :source %<CR>

" f -> find (fzf)
" nnoremap <silent> <leader>ff :Telescope find_files<CR>
nnoremap <silent> <leader>ff :lua File_picker()<CR>
nnoremap <silent> <leader>fd :lua require'telescope.builtin'.find_files({ search_dirs={'~/dotfiles'} })<CR>
nnoremap <silent> <leader>f~ :Files ~<CR>
nnoremap <silent> <Leader>f. :Files %:h<CR>
nnoremap <silent> <Leader>f. :lua require'telescope.builtin'.find_files({ search_dirs={"%:h"} })<CR>
" nnoremap <silent> <leader>fw :lua require'telescope.builtin'.find_files({ search_dirs={'~/Dropbox/org'} })<CR>
nnoremap <silent> <leader>fw :lua WikiPicker()<CR>
nnoremap <silent> <leader>of :lua WikiPicker()<CR>
nnoremap <leader>f<Space> :Files<Space>
nnoremap <silent> <Leader>fb :lua require'telescope.builtin'.buffers({sort_lastused = true; ignore_current_buffer = true, show_all_buffers = true, sorter = require'telescope.sorters'.get_substr_matcher()})<CR>
nnoremap <silent> <Leader>fB :Buffers<CR>
nnoremap <silent> <Leader>fq :Telescope quickfix<CR>
nnoremap <silent> <Leader>fh :lua FFHistoryPicker()<CR>
nnoremap <silent> <Leader>fm :Telescope lsp_document_symbols<CR>
nnoremap <silent>  <leader>; :Telescope command_history<CR>
nnoremap <leader>fo :lua SessionPicker()<CR>
nnoremap <leader>fs :lua SshPicker(false)<CR>
nnoremap <leader>fS :lua SshPicker(true)<CR>
nnoremap <leader>fp :lua PsqlPicker()<CR>
nnoremap <leader>fk :lua K8sPods()<CR>
inoremap <expr> <plug>(fzf-complete-path) fzf#vim#complete#path("fd . --color=never")
imap <c-x><c-f> <plug>(fzf-complete-path)
nnoremap <leader>cg :Gcd<CR>
nnoremap <leader>cl :lcd %:h<CR>
nnoremap <leader>cf :Cdz<CR>
nnoremap <leader>ch :cd ~<CR>
nnoremap <leader>c. :Cd .<CR>
nnoremap <leader>c<space> :Cd<space>

let g:toggle_list_no_mappings=1
nnoremap <silent> <Leader>qq :call ToggleQuickfixList()<CR>
nnoremap <silent> <Leader>ql :call ToggleLocationList()<CR>

" s -> search
nnoremap <silent> <leader>ss :Rg<CR>
nnoremap <silent> <leader>sd :Rg ~/dotfiles<CR>
nnoremap <silent> <leader>sw :Rg ~/Dropbox/wiki/<CR>
nnoremap <silent> <leader>se :VsnipOpen<CR>
nnoremap <silent> <leader>sE :Files $DOTFILES/nvim/lua/snips<CR>
" g -> git (fugutive)
" nnoremap <leader>G :Gedit :<CR>
" nnoremap <leader>gg :Gedit :<CR>
nnoremap <leader>G :G<CR>
nnoremap <leader>gg :G<CR>
nnoremap <leader>ge :Gedit<Space>
nnoremap <leader>gs :Gsplit<Space>
nnoremap <leader>gd :Gdiffsplit!<CR>
nnoremap <leader>gD :Git diff<CR>
nnoremap <leader>gl :GV<CR>
nnoremap <leader>gL :0Glog<CR>
nnoremap <leader>gb :GBrowse<CR>
vnoremap <leader>gb :GBrowse<CR>
nnoremap <leader>gB :Gblame<CR>
nnoremap <leader>gpdd :Git diff master...<CR> 
nnoremap <leader>gpdf :Gdiff master...:%<CR> 

" completion
" im<silent><expr> <Tab> compe#complete()
inoremap <silent><expr> <CR>  compe#confirm('<CR>')
inoremap <silent><expr> <C-e> compe#close('<C-e>')

" orgmode
nnoremap <silent><leader>oh :lua GetHeadlines()<CR>
nnoremap <silent><leader>oo :top split ~/Dropbox/org/agenda.org<CR>
au FileType org nnoremap <buffer><silent><leader>or :lua RefileHeadline()<CR>
au FileType org nnoremap <buffer><silent><leader>ok :wq<CR>
au FileType org nnoremap <buffer><silent>[[ :lua Headline_prev()<CR>
au FileType org nnoremap <buffer><silent>]] :lua Headline_next()<CR>
au FileType org nnoremap <buffer><silent>][ :lua Headline_down()<CR>
au FileType org nnoremap <buffer><silent>[] :lua Headline_up()<CR>
au FileType org nnoremap <buffer>H :lua Headline_prev()<CR>
au FileType org nnoremap <buffer>L :lua Headline_next()<CR>
au FileType org nnoremap <buffer>U :lua Headline_up()<CR>
" au FileType org nmap o o<ESC>i
" au FileType org nmap O O<ESC>i

nnoremap <leader>xx <cmd>TroubleToggle<cr>
nnoremap <leader>xw <cmd>TroubleToggle lsp_workspace_diagnostics<cr>

nnoremap <leader>xd <cmd>TroubleToggle lsp_document_diagnostics<cr>
nnoremap <leader>xq <cmd>TroubleToggle quickfix<cr>
nnoremap <leader>xl <cmd>TroubleToggle loclist<cr>
nnoremap <leader>xr <cmd>TroubleToggle lsp_references<cr>
nnoremap <leader>xi <cmd>TroubleToggle lsp_implemenations<cr>

" lsp
" nnoremap <silent> gd :Trouble lsp_definitions<CR>
nnoremap <silent> gd :lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD :lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> [d :lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> ]d :lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap <leader>ir :lua vim.lsp.buf.references()<CR>
nnoremap <leader>iR :lua vim.lsp.buf.implementation()<CR>
nnoremap <Leader>ie :Telescope lsp_document_diagnostics<CR>
nnoremap <leader>im :WorkspaceSymbols<CR>
nnoremap <leader>iM :DocumentSymbols<CR>
nnoremap <leader>in :lua vim.lsp.buf.rename()<CR>
nnoremap <leader>if :lua vim.lsp.buf.formatting()<CR>
vnoremap <leader>if :lua vim.lsp.buf.range_formatting()<CR>
nnoremap <leader>ii :lua vim.lsp.buf.code_action()<CR>
nnoremap <leader>is :SymbolsOutline<CR>
nnoremap <leader>ub :lua require'dap'.toggle_breakpoint()<CR>
nnoremap <leader>uB :Telescope dap list_breakpoints<CR>
nnoremap <leader>uu :lua require'dap'.continue()<CR>
nnoremap <leader>ui :lua require'dap'.step_into()<CR>
nnoremap <leader>uo :lua require'dap'.step_over()<CR>
nnoremap <leader>uO :lua require'dap'.step_out()<CR>
nnoremap <leader>ur :lua require'dap'.repl.open()<CR>
nnoremap <leader>uq :lua require'dap'.stop()<CR>
nnoremap <leader>uf :Telescope dap frames<CR>
nnoremap <leader>uv :Telescope dap variables<CR>
nnoremap <leader>ut :lua require'dapui'.toggle('sidebar')<CR>
nnoremap <leader>uT :lua require'dapui'.toggle('tray')<CR>
nnoremap <silent> K :lua require('lspsaga.hover').render_hover_doc()<CR>
nnoremap <silent> KK :lua require('lspsaga.hover').render_hover_doc()<CR>
nnoremap <silent> KS :lua require('lspsaga.signaturehelp').signature_help()<CR>
nnoremap <silent> KD :lua require'lspsaga.provider'.preview_definition()<CR>
nnoremap <silent> KE :lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>
nmap KG <Plug>(git-messenger)
" nnoremap <silent> Kd :lua require'dap.ui.variables'.hover()<CR>
" nnoremap <silent> KD :lua require'dap.ui.variables'.scopes()<CR>

nnoremap <leader>mk :sp \| top term make<CR>
nnoremap <leader>mK :sp \| top term make test<CR>

au FileType java nnoremap <buffer><leader>ii :lua require('jdtls').code_action()<CR>
au FileType java vnoremap <buffer><leader>ii <Esc><Cmd>lua require('jdtls').code_action(true)<CR>
au FileType java nnoremap <buffer><leader>iN <Cmd>lua require('jdtls').code_action(false, 'refactor')<CR>
au FileType java nnoremap <buffer><leader>uc <Cmd>lua require'jdtls'.test_class()<CR>
au FileType java nnoremap <buffer><leader>um <Cmd>lua require'jdtls'.test_nearest_method()<CR>

autocmd BufWritePre *.go :silent! lua vim.lsp.buf.formatting_sync(nil,500)

au FileType python nnoremap <buffer><leader>Im <Cmd>lua require'dap-python'.test_method()<CR>
au FileType python vnoremap <buffer><leader>Is <Esc>:lua require'dap-python'.debug_selection()<CR>

function! ToggleSignColumn()
    if !exists("b:signcolumn_on") || !b:signcolumn_on
        set signcolumn=yes
        let b:signcolumn_on=1
    else
        set signcolumn=no
        let b:signcolumn_on=0
    endif
endfunction
nnoremap <Leader>` :call ToggleSignColumn()<CR>

imap <expr> <Tab>   vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<Tab>'
smap <expr> <Tab>   vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
imap <expr> <C-l>   vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<Tab>'
smap <expr> <C-l>   vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<Tab>'
imap <expr> <C-h>   vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)'      : '<C-h>'
smap <expr> <C-h>   vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)'      : '<C-h>'
