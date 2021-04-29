require 'F'
require 'log'
require 'plugins'
require 'treesitter'
require 'functions'
require 'lsp'
require 'options'

require'colorizer'.setup()

vim.cmd "command! -nargs=? -complete=dir Rg lua RipgrepFzf(<q-args>)"
vim.cmd "command! -nargs=? -complete=dir Cd lua Cd(<q-args>)"
vim.cmd "command! -nargs=0 -complete=dir Cdz lua Cdz()"
vim.cmd "command! -nargs=1 Google lua SearchGoogle(<q-args>)"
vim.cmd "command! -nargs=0 Prs lua Prs()"

-- vim.cmd "autocmd BufEnter * lua require'completion'.on_attach()"
vim.cmd "autocmd FileType javascript,js,javascript.jsx,typescript,typescriptreact setlocal shiftwidth=2 softtabstop=2 tabstop=2 expandtab"
vim.cmd "autocmd BufReadPost fugitive://* set bufhidden=delete"
-- vim.cmd "autocmd BufReadPost jdt://* set bufhidden=delete"
