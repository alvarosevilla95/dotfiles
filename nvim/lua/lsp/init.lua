local M = {}

require 'lsp.go'
require 'lsp.java'
require 'lsp.rust'

local lspconfig = require 'lspconfig'
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true;
lspconfig.gopls.setup{capabilities=capabilities}
lspconfig.tsserver.setup{capabilities=capabilities}
lspconfig.vimls.setup{capabilities=capabilities}
lspconfig.pyright.setup{capabilities=capabilities}

require('dap-python').setup('~/.pyenv/shims/python')

local sumneko_root_path = '/Users/alvaro/.cache/nvim/nlua/sumneko_lua/lua-language-server'
local sumneko_binary = sumneko_root_path.."/bin/macOS/lua-language-server"
require("lua-dev").setup {
    lspconfig = {
        cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
    },
}

vim.lsp.handlers['textDocument/codeAction'] = require'lsputil.codeAction'.code_action_handler
vim.lsp.handlers['textDocument/references'] = require'lsputil.locations'.references_handler
vim.lsp.handlers['textDocument/implementation'] = require'lsputil.locations'.implementation_handler
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, { underline = false })
require'lspsaga'.init_lsp_saga{
    use_saga_diagnostic_sign = false,
    code_action_prompt = {
        enable = false,
    },
}

require("dapui").setup({
    icons = {
        expanded = "▾",
        collapsed = "▸"
    },
    mappings = {
        expand = {"<CR>", "<2-LeftMouse>"},
        open = "o",
        remove = "d",
        edit = "e",
    },
    sidebar = {
        open_on_start = true,
        elements = {
            "scopes",
            "watches",
            "repl",
        },
        width = 40,
        position = "left"
    },
    tray = {
        open_on_start = false,
        elements = {
            "repl",
        },
        height = 10,
        position = "bottom"
    },
    floating = {
        max_height = nil,
        max_width = nil
    }
})

return M
