local M = {}

local lspconfig = require 'lspconfig'
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true;
lspconfig.gopls.setup{capabilities=capabilities}
lspconfig.tsserver.setup{capabilities=capabilities}
lspconfig.vimls.setup{capabilities=capabilities}
lspconfig.pyright.setup{capabilities=capabilities}
vim.lsp.handlers['textDocument/codeAction'] = require'lsputil.codeAction'.code_action_handler

vim.cmd "autocmd FileType java,groovy lua require'lsp'.java_setup()"
function M.java_setup()
    local on_attach = function(client, bufnr)
        require'jdtls.setup'.add_commands()
        require('jdtls').setup_dap()
        -- require'jdtls'.setup_dap()
        require'lsp-status'.register_progress()
        vim.g.completion_matching_strategy_list = {'exact', 'substring', 'fuzzy', 'all'}
        require'lspkind'.init()
        require'lspsaga'.init_lsp_saga()

        -- require'formatter'.setup{
        --     filetype = { java = {
        --             function()
        --                 return {
        --                     exe = 'java',
        --                     args = { '-jar', os.getenv('HOME') .. '/.local/jars/google-java-format.jar', vim.api.nvim_buf_get_name(0) },
        --                     stdin = true
        --                 }
        --             end
        --         }
        --     }
        -- }

        -- vim.api.nvim_exec([[
        --   augroup FormatAutogroup
        --     autocmd!
        --     autocmd BufWritePost *.java FormatWrite
        --   augroup end
        -- ]], true)

        -- local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
        -- local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

        -- buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

        -- Mappings.
        -- local opts = { noremap=true, silent=true }
        -- buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
        -- buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
        -- buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
        -- buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
        -- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
        -- buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
        -- buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
        -- buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
        -- buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
        -- buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
        -- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references() && vim.cmd("copen")<CR>', opts)
        -- buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
        -- buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
        -- buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
        -- buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
        -- -- Java specific
        -- buf_set_keymap("n", "<leader>di", "<Cmd>lua require'jdtls'.organize_imports()<CR>", opts)
        -- buf_set_keymap("n", "<leader>dt", "<Cmd>lua require'jdtls'.test_class()<CR>", opts)
        -- buf_set_keymap("n", "<leader>dn", "<Cmd>lua require'jdtls'.test_nearest_method()<CR>", opts)
        -- buf_set_keymap("v", "<leader>de", "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", opts)
        -- buf_set_keymap("n", "<leader>de", "<Cmd>lua require('jdtls').extract_variable()<CR>", opts)
        -- buf_set_keymap("v", "<leader>dm", "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", opts)

        -- buf_set_keymap("n", "<leader>cf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

        -- vim.api.nvim_exec([[
        --     hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
        --     hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
        --     hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
        --     augroup lsp_document_highlight
        --       autocmd!
        --       autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        --       autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        --     augroup END
        -- ]], false)

    end

    local root_markers = {'gradlew', 'pom.xml'}
    local root_dir = require('jdtls.setup').find_root(root_markers)
    local home = os.getenv('HOME')

    -- Remove .settings on start, see https://github.com/mfussenegger/nvim-jdtls/issues/38
    if root_dir ~=nil then
        local f=io.open(root_dir .. "/build.gradle","r")
        if f~=nil then
            io.close(f)
            -- vim.g['test#java#runner'] = 'gradletest'
            vim.api.nvim_exec([[
            let test#java#runner = 'gradletest'
            ]], true)
            os.execute("rm -rf " .. root_dir .. "/.settings")
        end
    end

    local capabilities = {
        workspace = {
            configuration = true
        },
        textDocument = {
            completion = {
                completionItem = {
                    snippetSupport = true
                }
            }
        }
    }

    local workspace_folder = home .. "/.workspace-" .. vim.fn.fnamemodify(root_dir, ":p:h:t")
    local config = {
        flags = {
            allow_incremental_sync = true,
        };
        capabilities = capabilities,
        on_attach = on_attach,
    }

    config.settings = {
        -- ['java.format.settings.url'] = home .. "/.config/nvim/language-servers/java-google-formatter.xml",
        -- ['java.format.settings.profile'] = "GoogleStyle",
        java = {
            signatureHelp = { enabled = true };
            contentProvider = { preferred = 'fernflower' };
            completion = {
                favoriteStaticMembers = {
                    "org.hamcrest.MatcherAssert.assertThat",
                    "org.hamcrest.Matchers.*",
                    "org.hamcrest.CoreMatchers.*",
                    "org.junit.jupiter.api.Assertions.*",
                    "java.util.Objects.requireNonNull",
                    "java.util.Objects.requireNonNullElse",
                    "org.mockito.Mockito.*"
                }
            };
            sources = {
                organizeImports = {
                    starThreshold = 9999;
                    staticStarThreshold = 9999;
                };
            };
            codeGeneration = {
                toString = {
                    template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
                }
            };
            configuration = {
                runtimes = {
                    {
                        name = "JavaSE-11",
                        path = home .. "/.sdkman/candidates/java/11.0.2-open/",
                    },
                    {
                        name = "JavaSE-14",
                        path = home .. "/.sdkman/candidates/java/14.0.2-open/",
                    },
                }
            };
        };
    }
    config.cmd = {'/Users/alvaro/dotfiles/bin/start-java-lsp.sh', workspace_folder}
    config.on_attach = on_attach
    config.on_init = function(client, _)
        client.notify('workspace/didChangeConfiguration', { settings = config.settings })
    end

    -- local jar_patterns = {
    --     '/dev/microsoft/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar',
    --     '/dev/dgileadi/vscode-java-decompiler/server/*.jar',
    --     '/dev/microsoft/vscode-java-test/server/*.jar',
    -- }
    -- local bundles = {}
    -- for _, jar_pattern in ipairs(jar_patterns) do
    --   for _, bundle in ipairs(vim.split(vim.fn.glob(home .. jar_pattern), '\n')) do
    --     if not vim.endswith(bundle, 'com.microsoft.java.test.runner.jar') then
    --       table.insert(bundles, bundle)
    --     end
    --   end
    -- end

    local extendedClientCapabilities = require'jdtls'.extendedClientCapabilities
    extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

    local bundles = {
        vim.fn.glob("/Users/alvaro/Developer/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar"),
    };
    vim.list_extend(bundles, vim.split(vim.fn.glob("/Users/alvaro/Developer/java-debug/server/*.jar"), "\n"))
    config.init_options = {
        -- bundles = bundles;
        bundles = bundles;
        extendedClientCapabilities = extendedClientCapabilities;
    }

    require'jdtls.ui'.pick_one_async = function(items, _, _, cb)
        require'lsputil.codeAction'.code_action_handler(nil, nil, items, nil, nil, nil, cb)
    end

    -- Server
    require('jdtls').start_or_attach(config)
end

require('dap-python').setup('~/.pyenv/shims/python')

local dap = require'dap'

-- dap.adapters.go = {
--     type = 'executable';
--     command = 'node';
--     args = {os.getenv('HOME') .. '/Developer/vscode-go/dist/debugAdapter.js'};
-- }
-- dap.configurations.go = {
--     {
--         type = 'go';
--         name = 'Debug';
--         request = 'launch';
--         showLog = false;
--         program = "${file}";
--         dlvToolPath = vim.fn.exepath('dlv')  -- Adjust to where delve is installed
--     },
-- }
dap.adapters.go = function(callback, config)
    local handle
    local pid_or_err
    local port = 38697
    handle, pid_or_err =
      vim.loop.spawn(
      "dlv",
      {
        args = {"dap", "-l", "127.0.0.1:" .. port},
        detached = true
      },
      function(code)
        handle:close()
        print("Delve exited with exit code: " .. code)
      end
    )
     ----should we wait for delve to start???
    --vim.defer_fn(
    --function()
      --dap.repl.open()
      --callback({type = "server", host = "127.0.0.1", port = port})
    --end,
    --100)

      callback({type = "server", host = "127.0.0.1", port = port})
  end
  -- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
  dap.configurations.go = {
    {
      type = "go",
      name = "Debug",
      request = "launch",
      program = "${file}"
    }
  }

-- Your custom attach function for nvim-lspconfig goes here.
-- local custom_nvim_lspconfig_attach = function(...) end

-- To get builtin LSP running, do something like:
-- -- NOTE: This replaces the calls where you would have before done `require('nvim_lsp').sumneko_lua.setup()`
-- require('nlua.lsp.nvim').setup(require('lspconfig'), {
--   -- on_attach = custom_nvim_lspconfig_attach,
  
--   root_dir = function(fname)
--     if string.find(vim.fn.fnamemodify(fname, ":p"), "dotfiles/nvim/") then
--       return vim.fn.expand("~/dotfiles/nvim")
--     end

--     -- ~/git/config_manager/xdg_config/nvim/...
--     return lspconfig_util.find_git_ancestor(fname)
--       or lspconfig_util.path.dirname(fname)
--   end,

--   -- -- Include globals you want to tell the LSP are real :)
--   -- globals = {
--   --   -- Colorbuddy
--   --   "Color", "c", "Group", "g", "s",
--   -- }
-- })
local sumneko_root_path = '/Users/alvaro/.cache/nvim/nlua/sumneko_lua/lua-language-server'
local sumneko_binary = sumneko_root_path.."/bin/macOS/lua-language-server"

require'lspconfig'.sumneko_lua.setup {
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
          [vim.fn.expand('/Users/alvaro/.local/nvim/site/pack/packer/start')] = true,
        },
      },
    },
  },
}

vim.lsp.handlers["textDocument/publishDiagnostics"] =
  vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics,
  {
    underline = false
  }
)

return M


