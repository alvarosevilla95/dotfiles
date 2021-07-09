local o = vim.opt
o.termguicolors  = true;
o.updatetime     = 100;
o.splitright     = true;
o.hidden         = true;
o.wildmenu       = true;
o.showcmd        = true;
o.hlsearch       = true;
o.ignorecase     = true;
o.smartcase      = true;
o.backspace      = 'indent,eol,start';
o.ruler          = true;
o.laststatus     = 2
o.confirm        = true;
o.visualbell     = true;
o.mouse          = 'a';
o.timeout        = false
o.ttimeout       = true;
o.ttimeoutlen    = 0;
o.pastetoggle    = '<F11>';
o.clipboard      = 'unnamed';
o.showmode       = false;
o.autowrite      = true;
o.wildmode       = 'longest,full';
o.foldlevel      = 2;
o.shortmess      = 'IOc';
o.completeopt    = 'menuone,noselect'; -- 'menuone,noinsert,noselect';
o.tabstop        = 4;
o.shiftwidth     = 4;
o.softtabstop    = 4;
o.expandtab      = true;
o.cursorline     = true;
o.relativenumber = true;
o.number         = true;
o.signcolumn     = 'no';
o.autoindent     = true;
o.expandtab      = true;
o.tabstop        = 4;
o.shiftwidth     = 4;
o.softtabstop    = 4;
o.grepprg='rg --vimgrep --no-heading --smart-case'
o.grepformat='%f:%l:%c:%m,%f:%l:%m'
o.showtabline = 2

Tabline = require'luatab'.tabline
vim.cmd[[ set tabline=%!luaeval('Tabline()') ]]

require 'lib'
require 'plugins'
require 'treesitter'
require 'functions'
require 'lsp'

vim.cmd "command! -nargs=? Sgrep silent grep <q-args>"
vim.cmd "command! -nargs=? -complete=dir Rg lua RipgrepFzf(<q-args>)"
vim.cmd "command! -nargs=? -complete=dir Cd lua Cd(<q-args>)"
vim.cmd "command! -nargs=0 -complete=dir Cdz lua Cdz()"
vim.cmd "command! -nargs=1 Google lua SearchGoogle(<q-args>)"
vim.cmd "command! -nargs=0 Prs lua Prs()"
vim.cmd "command! -nargs=0 Clip e ~/Dropbox/wiki/clipboard.md"
vim.cmd "command! -nargs=0 JdtMainClasses lua require('jdtls.dap').setup_dap_main_class_configs()"
vim.cmd "command! -nargs=1 Pandoc lua PandocOpen(vim.fn.expand('%'), <q-args>)"
vim.cmd "command! -nargs=0 PrOpen :sp | term gh pr create"
vim.cmd "command! -nargs=1 Clone :lua Clone(<q-args>)"

vim.cmd "autocmd FileType javascript,js,javascript.jsx,typescript,typescriptreact setlocal shiftwidth=2 softtabstop=2 tabstop=2 expandtab"
vim.cmd "au FileType org setlocal shiftwidth=2 softtabstop=2 tabstop=2 expandtab"
vim.cmd "autocmd BufReadPost fugitive://* set bufhidden=delete"
vim.cmd "autocmd BufRead,BufNewFile *.hcl set filetype=terraform"

vim.cmd" command! -nargs=0 Hex silent %!xxd"
vim.cmd" command! -nargs=0 HexWrite silent %!xxd -r"

