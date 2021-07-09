local sumneko_root_path = '/Users/alvaro/.cache/nvim/nlua/sumneko_lua/lua-language-server'
local sumneko_binary = sumneko_root_path.."/bin/macOS/lua-language-server"
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

require'lspconfig'.sumneko_lua.setup {
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
  on_attach = function() require'lsp_signature'.on_attach() end,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = runtime_path,
      },
      diagnostics = {
        globals = {'vim'},
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        preloadFileSize = 500,
      },
      telemetry = {
        enable = false,
      },
    },
  },
}

