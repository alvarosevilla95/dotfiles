local M = {}

local lspconfig = require 'lspconfig'
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true;
lspconfig.gopls.setup{capabilities=capabilities}
lspconfig.tsserver.setup{capabilities=capabilities}
lspconfig.vimls.setup{capabilities=capabilities}
lspconfig.pyright.setup{capabilities=capabilities}

vim.lsp.handlers['textDocument/codeAction'] = require'lsputil.codeAction'.code_action_handler
vim.lsp.handlers["textDocument/publishDiagnostics"] =
  vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics,
  {
    underline = false
  }
)

require('rust-tools').setup{
    tools = { -- rust-tools options
        -- automatically set inlay hints (type hints)
        -- There is an issue due to which the hints are not applied on the first
        -- opened file. For now, write to the file to trigger a reapplication of
        -- the hints or just run :RustSetInlayHints.
        -- default: true
        autoSetHints = true,

        -- whether to show hover actions inside the hover window
        -- this overrides the default hover handler
        -- default: true
        hover_with_actions = true,

        runnables = {
            -- whether to use telescope for selection menu or not
            -- default: true
            use_telescope = true

            -- rest of the opts are forwarded to telescope
        },

        inlay_hints = {
            -- wheter to show parameter hints with the inlay hints or not
            -- default: true
            show_parameter_hints = true,

            -- prefix for parameter hints
            -- default: "<-"
            parameter_hints_prefix = "<-",

            -- prefix for all the other hints (type, chaining)
            -- default: "=>"
            other_hints_prefix  = "=>",

            -- whether to align to the lenght of the longest line in the file
            max_len_align = false,

            -- padding from the left if max_len_align is true
            max_len_align_padding = 1,

            -- whether to align to the extreme right or not
            right_align = false,

            -- padding from the right if right_align is true
            right_align_padding = 7,
        },

        hover_actions = {
            -- the border that is used for the hover window
            -- see vim.api.nvim_open_win()
            border = {
              {"╭", "FloatBorder"},
              {"─", "FloatBorder"},
              {"╮", "FloatBorder"},
              {"│", "FloatBorder"},
              {"╯", "FloatBorder"},
              {"─", "FloatBorder"},
              {"╰", "FloatBorder"},
              {"│", "FloatBorder"}
            },
        }
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
    server = {}, -- rust-analyer options
}

vim.cmd "autocmd FileType java,groovy lua require'lsp'.java_setup()"
function M.java_setup()
    local on_attach = function(client, bufnr)
        require'jdtls.setup'.add_commands()
        require('jdtls').setup_dap({ hotcodereplace = 'auto' })
        -- require'jdtls'.setup_dap()
        require'lsp-status'.register_progress()
        vim.g.completion_matching_strategy_list = {'exact', 'substring', 'fuzzy', 'all'}
        require'lspkind'.init()
        require'lspsaga'.init_lsp_saga()
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

    local extendedClientCapabilities = require'jdtls'.extendedClientCapabilities
    extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

    local bundles = {
        vim.fn.glob("/Users/alvaro/Developer/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar"),
    };
    vim.list_extend(bundles, vim.split(vim.fn.glob("/Users/alvaro/Developer/java-debug/server/*.jar"), "\n"))
    config.init_options = {
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

local sumneko_root_path = '/Users/alvaro/.cache/nvim/nlua/sumneko_lua/lua-language-server'
local sumneko_binary = sumneko_root_path.."/bin/macOS/lua-language-server"
local luadev = require("lua-dev").setup {
  lspconfig = {
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
  },
}

require('go').setup({
  goimport='gofumports', -- g:go_nvim_goimport
  gofmt = 'gofumpt', --g:go_nvim_gofmt,
  max_len = 120, -- g:go_nvim_max_len
  transform = false, -- vim.g.go_nvim_tag_transfer  check gomodifytags for details
  test_template = '', -- default to testify if not set; g:go_nvim_tests_template  check gotests for details
  test_template_dir = '', -- default to nil if not set; g:go_nvim_tests_template_dir  check gotests for details
  comment_placeholder = '' ,  -- vim.g.go_nvim_comment_placeholder your cool placeholder e.g. ﳑ       
  verbose = false,  -- output loginf in messages
})

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
    -- Wait 100ms for delve to start
    vim.defer_fn(
    function()
        --dap.repl.open()
        callback({type = "server", host = "127.0.0.1", port = port})
    end,
    100)


    --callback({type = "server", host = "127.0.0.1", port = port})
end
-- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
dap.configurations.go = {
    {
        type = "go",
        name = "Debug",
        request = "launch",
        program = "${file}"
    },
    {
        type = "go",
        name = "Debug test", -- configuration for debugging test files
        request = "launch",
        mode = "test",
        program = "${file}"
    },
}

require("dapui").setup({
  icons = {
    expanded = "▾",
    collapsed = "▸"
  },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = {"<CR>", "<2-LeftMouse>"},
    open = "o",
    remove = "d",
    edit = "e",
  },
  sidebar = {
    open_on_start = true,
    elements = {
      -- You can change the order of elements in the sidebar
      "scopes",
      "watches",
      "repl",
    },
    width = 40,
    position = "left" -- Can be "left" or "right"
  },
  tray = {
    open_on_start = false,
    elements = {
      "repl",
    },
    height = 10,
    position = "bottom" -- Can be "bottom" or "top"
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil   -- Floats will be treated as percentage of your screen.
  }
})

return M
