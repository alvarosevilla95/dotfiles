vim.cmd "autocmd FileType java,groovy lua require'lsp.java'.java_setup()"

local M = {}

function M.java_setup()
    local on_attach = function(client, bufnr)
        require'jdtls.setup'.add_commands()
        require('jdtls').setup_dap({ hotcodereplace = 'auto' })
        -- require'jdtls'.setup_dap()
        require'lsp-status'.register_progress()
        vim.g.completion_matching_strategy_list = {'exact', 'substring', 'fuzzy', 'all'}
        require'lspkind'.init()
        require'lspsaga'.init_lsp_saga()
        require'lsp_signature'.on_attach()
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

return M
