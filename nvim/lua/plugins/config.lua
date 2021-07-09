local g = vim.g
g.python3_host_prog = "/Users/alvaro/.pyenv/shims/python"
g.netrw_liststyle = 3
g.netrw_fastbrowse = 0
g.fzf_history_dir = '~/.local/share/fzf-history'
g.fzf_layout = { window = { width = 0.9, height = 0.9, highlight = 'Comment' } }
g.vimwiki_list = {{ syntax = 'markdown', ext = '.md', path = '/Users/alvaro/Dropbox/wiki/'}}
g.vimwiki_global_ext = 0
g.vimwiki_ext2syntax = {['.md'] = 'markdown',['.markdown'] = 'markdown', ['.mdown'] = 'markdown'}
g.vimwiki_key_mappings = { all_maps = 0, }
g.git_messenger_no_default_mappings = true
g.bclose_no_plugin_maps=true
g.dap_virtual_text = true
g.symbols_outline = {
    highlight_hovered_item = true,
    show_guides = true,
    auto_preview = true,
    position = 'right',
    show_numbers = false,
    show_relative_numbers = false,
    show_symbol_details = true,
    keymaps = {
        close = "<Esc>",
        goto_location = "<Cr>",
        focus_location = "o",
        hover_symbol = "<C-space>",
        rename_symbol = "r",
        code_actions = "a",
    },
    lsp_blacklist = {},
}

require'colorizer'.setup({'*'}, { names = false })

require'compe'.setup {
    enabled = true,
    autocomplete = true,
    debug = false,
    min_length = 1,
    preselect = 'always',
    -- preselect = 'enable',
    throttle_time = 80,
    source_timeout = 200,
    incomplete_delay = 400,
    max_abbr_width = 100,
    max_kind_width = 100,
    max_menu_width = 100,
    documentation = true,
    border = true,
    source = {
        path = true,
        buffer = true,
        calc = true,
        vsnip = {priority=10000},
        nvim_lsp = true,
        nvim_lua = true,
        spell = true,
        tags = true,
        treesitter = true,
        orgmode = true,
    },
}

require('lualine').setup{
    options = {
        theme = 'gruvbox'
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'Cwd()'},
        lualine_c = {'filename'},
        lualine_x = {'filetype', 'branch'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
    }
}

require'sniprun'.setup({
    selected_interpreters = { 'Python3_fifo' },
    repl_enable = {'Python3_fifo'},
    repl_disable = {},
    interpreter_options = {},
    display = {
        "Terminal",
        "VirtualTextOk",
        "VirtualTextErr",
        -- "Classic",
        -- "TempFloatingWindow",
        -- "LongTempFloatingWindow",
    },
    snipruncolors = {
        SniprunVirtualTextOk   =  {bg="#66eeff",fg="#000000",ctermbg="Cyan",cterfg="Black"},
        SniprunFloatingWinOk   =  {fg="#66eeff",ctermfg="Cyan"},
        SniprunVirtualTextErr  =  {bg="#881515",fg="#000000",ctermbg="DarkRed",cterfg="Black"},
        SniprunFloatingWinErr  =  {fg="#881515",ctermfg="DarkRed"},
    },
    inline_messages = 0,
    borders = 'single'
})

require'nvim-web-devicons'.setup {
    override = {
        telescope = {
            icon = "",
            color = "#428850",
            name = "Telescope"
        },
        org = {
            icon = "",
            color = "#881515",
            name = "Orgmode"
        },
    },
    default = false;
}

require('lspkind').init {
    symbol_map = {
        Text = '',
        Method = 'ƒ',
        Function = '',
        Constructor = '',
        Variable = '',
        Class = '',
        Interface = 'ﰮ',
        Module = '',
        Property = '',
        Unit = '',
        Value = '',
        Enum = '了',
        Keyword = '',
        Snippet = '﬌',
        Color = '',
        File = '',
        Folder = '',
        EnumMember = '',
        Constant = '',
        Struct = '',
        Field = '',
    },
}

