-- Neovim configuraion
vim.o.termguicolors   = true;
vim.o.background      = 'dark';
vim.o.updatetime      = 100;
vim.o.splitright      = true;
vim.o.hidden          = true;
vim.o.wildmenu        = true;
vim.o.showcmd         = true;
vim.o.hlsearch        = true;
vim.o.ignorecase      = true;
vim.o.smartcase       = true;
vim.o.backspace       = 'indent,eol,start';
vim.o.ruler           = true;
vim.o.laststatus      = 2
vim.o.confirm         = true;
vim.o.visualbell      = true;
vim.o.mouse           = 'a';
vim.o.timeout         = false
vim.o.ttimeout        = true;
vim.o.ttimeoutlen     = 0;
vim.o.pastetoggle     = '<F11>';
vim.o.clipboard       = 'unnamed';
vim.o.showmode        = false;
vim.o.autowrite       = true;
vim.o.wildmode        = 'longest,full';
vim.o.foldlevel       = 2;
vim.o.shortmess       = 'I';
vim.wo.cursorline     = true;
vim.wo.relativenumber = true;
vim.wo.number         = true;
vim.wo.signcolumn     = 'no';
vim.bo.autoindent     = true;
vim.bo.tabstop        = 4;
vim.bo.shiftwidth     = 4;
vim.bo.softtabstop    = 4;
vim.bo.expandtab      = true;
-- vim.o.undofile
-- vim.o.undodir=~/.config/nvim/undodir

vim.g.gruvbox_contrast_dark = "hard"
vim.g.gruvbox_contrast_light = "soft"
vim.cmd 'colorscheme gruvbox';

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

local actions = require('telescope.actions')
require('telescope').setup{
    defaults = {
        mappings = {
            i = {
                -- To disable a keymap, put [map] = false
                -- So, to not map "<C-n>", just put
                -- ["<c-x>"] = false,
                -- Otherwise, just set the mapping to the function that you want it to be.
                -- ["<C-i>"] = actions.goto_file_selection_split,
                -- Add up multiple actions
                -- ["<CR>"] = actions.goto_file_selection_edit + actions.center,
                -- You can perform as many actions in a row as you like
                -- ["<CR>"] = actions.goto_file_selection_edit + actions.center + my_cool_custom_action,
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
            },
            n = {
                ["<esc>"] = actions.close,
                ["<C-i>"] = my_cool_custom_action,
            },
        },
        vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case'
        },
        prompt_position = "top",
        prompt_prefix = ">",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_defaults = {
            -- TODO add builtin options.
        },
        file_sorter =  require'telescope.sorters'.get_fuzzy_file,
        file_ignore_patterns = {},
        generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
        shorten_path = true,
        winblend = 0,
        width = 0.75,
        preview_cutoff = 120,
        results_height = 1,
        results_width = 0.8,
        border = {},
        borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰'},
        color_devicons = true,
        use_less = true,
        set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
        file_previewer = require'telescope.previewers'.cat.new, -- For buffer previewer use `require'telescope.previewers'.vim_buffer_cat.new`
        grep_previewer = require'telescope.previewers'.vimgrep.new, -- For buffer previewer use `require'telescope.previewers'.vim_buffer_vimgrep.new`
        qflist_previewer = require'telescope.previewers'.qflist.new, -- For buffer previewer use `require'telescope.previewers'.vim_buffer_qflist.new`

        -- Developer configurations: Not meant for general override
        buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
    }
}

