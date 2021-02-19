vim.g.python3_host_prog = "/Users/alvaro/.pyenv/shims/python"

vim.g.lightline = {
    tabline = {
        left = {{'tabs'}},
        right = {{''}},
    },
    colorscheme = 'gruvbox',
    active = {
        left =  {{'mode', 'paste'}, {'fugitive'}, {'filename'}},
        right = {{'lineinfo'}, {'percent'}, {'filetype'}},
    },
    component_function = {
        fugitive = 'FugitiveHead',
    },
}

vim.g["deoplete#enable_at_startup"] = 1
vim.g.ranger_map_keys = 0
vim.g.netrw_liststyle = 3

vim.g.UltiSnipsExpandTrigger="<tab>"
vim.g.UltiSnipsJumpForwardTrigger="<c-j>"
vim.g.UltiSnipsJumpBackwardTrigger="<c-k>"

vim.g.fzf_history_dir = '~/.local/share/fzf-history'
vim.g.fzf_layout = { window = { width = 0.9, height = 0.9, highlight = 'Comment' } }

local wiki_1 = { syntax = 'markdown', ext = '.md', path = '/Users/alvaro/Dropbox/wiki/'}
vim.g.vimwiki_list = {wiki_1}
vim.g.vimwiki_global_ext = 0
vim.g.vimwiki_ext2syntax = {['.md'] = 'markdown',['.markdown'] = 'markdown', ['.mdown'] = 'markdown'}

require'lspconfig'.gopls.setup{}
require'lspconfig'.tsserver.setup{}
require'lspconfig'.vimls.setup{}
require'lspconfig'.pyright.setup{}

local jdtls_ui = require'jdtls.ui'
function jdtls_ui.pick_one_async(items, _, _, cb)
    require'lsputil.codeAction'.code_action_handler(nil, nil, items, nil, nil, nil, cb)
end

require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
  },
}

}


