vim.o.termguicolors   = true;
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
vim.o.shortmess       = 'IOc';
-- vim.o.completeopt     = 'menuone,noinsert,noselect';
vim.o.completeopt     = 'menuone,noselect';
vim.o.tabstop         = 4;
vim.o.shiftwidth      = 4;
vim.o.softtabstop     = 4;
vim.o.expandtab       = true;
vim.wo.cursorline     = true;
vim.wo.relativenumber = true;
vim.wo.number         = true;
vim.wo.signcolumn     = 'no';
vim.bo.autoindent     = true;
vim.bo.expandtab      = true;
vim.bo.tabstop        = 4;
vim.bo.shiftwidth     = 4;
vim.bo.softtabstop    = 4;

vim.g.python3_host_prog = "/Users/alvaro/.pyenv/shims/python"
vim.g.netrw_liststyle = 3
-- vim.g.completion_enable_snippet = 'UltiSnips'
-- vim.g.completion_confirm_key = ""
-- vim.g.completion_items_priority = { ['Variable'] = 5, ['Method'] = 4, ['Field'] = 4, ['Class'] = 3, ['Interface'] = 3, }
vim.g.ranger_map_keys = 0
-- vim.g.UltiSnipsExpandTrigger="<tab>"
vim.g.UltiSnipsJumpForwardTrigger="<c-j>"
vim.g.UltiSnipsJumpBackwardTrigger="<c-k>"
vim.g.fzf_history_dir = '~/.local/share/fzf-history'
vim.g.fzf_layout = { window = { width = 0.9, height = 0.9, highlight = 'Comment' } }
vim.g.vimwiki_list = {{ syntax = 'markdown', ext = '.md', path = '/Users/alvaro/Dropbox/wiki/'}}
vim.g.vimwiki_global_ext = 0
vim.g.vimwiki_ext2syntax = {['.md'] = 'markdown',['.markdown'] = 'markdown', ['.mdown'] = 'markdown'}
vim.g.vimwiki_key_mappings = { all_maps = 0, }
vim.g.git_messenger_no_default_mappings = true
vim.g.lightline = {
    tabline = { left = {{'tabs'}}, right = {{''}}, },
    colorscheme = 'gruvbox',
    active = {
        left =  {{'mode', 'paste'}, {'fugitive'}, {'absolutepath'}},
        right = {{'lineinfo'}, {'percent'}, {'filetype'}},
    },
    component_function = { fugitive = 'FugitiveHead', },
}

vim.g.UltiSnipsEditSplit="vertical"
vim.g.gruvbox_contrast_dark = "hard"
vim.g.gruvbox_contrast_light = "medium"
-- vim.g.nvim_tree_auto_open = 1
vim.cmd 'colorscheme gruvbox';
vim.o.grepprg='rg --vimgrep --no-heading --smart-case'
vim.o.grepformat='%f:%l:%c:%m,%f:%l:%m'
-- vim.cmd 'autocmd BufEnter * silent! lcd %:p:h'
vim.g.bclose_no_plugin_maps=true
vim.g.dap_virtual_text = true
vim.g.netrw_fastbrowse = 0

local snippets = require'snippets'
snippets.snippets = {
    _global = require'snips.global',
    lua = require'snips.lua',
}


require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'always';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = true;
    calc = true;
    snippets_nvim = true;
    nvim_lsp = true;
    nvim_lua = true;
    spell = true;
    tags = true;
    treesitter = true;
    -- ultisnips = {
    --     priority = 100000,
    -- };
  };
}


local actions = require('telescope.actions')
require('telescope').setup {
    defaults = {
        mappings = {
            i = {
                -- To disable a keymap, put [map] = false
                -- So, to not map "<C-n>", just put
                ["<c-x>"] = false,

                -- Otherwise, just set the mapping to the function that you want it to be.
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,

                -- Add up multiple actions
                ["<CR>"] = actions.select_default + actions.center,

            },
            n = {
                ["<esc>"] = actions.close,
            },
        },
    },
    extensions = {
        fzf_writer = {
            -- minimum_grep_characters = 2,
            -- minimum_files_characters = 2,

            -- Disabled by default.
            -- Will probably slow down some aspects of the sorter, but can make color highlights.
            -- I will work on this more later.
            use_highlighter = true,
        }
    }
}

vim.cmd[[ autocmd ColorScheme * lua require'nvim-web-devicons'.setup() ]]

require('lualine').setup{
    options = {
        theme = 'gruvbox'
    }
}
