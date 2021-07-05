local install_path = vim.fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.cmd('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
end

vim.cmd 'packadd packer.nvim'
vim.cmd 'autocmd BufWritePost plugins.lua PackerCompile'

require('packer').startup(function(use)
    use {'wbthomason/packer.nvim', opt = true}
    use { 'npxbr/gruvbox.nvim', requires = {"rktjmp/lush.nvim"}}

    -- External tools
    use { 'junegunn/fzf', run = function() vim.fn['fzf#install']() end }
    use 'junegunn/fzf.vim'
    use 'vimwiki/vimwiki'
    use 'lingceng/z.vim'
    use 'benmills/vimux'
    use 'christoomey/vim-run-interactive'

    -- Editing
    use "rafamadriz/friendly-snippets"
    use 'hrsh7th/vim-vsnip'
    use 'tpope/vim-surround'
    use 'tpope/vim-commentary'
    use 'svermeulen/vim-yoink'
    use 'tpope/vim-unimpaired'
    use 'tpope/vim-repeat'
    use 'tpope/vim-abolish'
    use 'tpope/vim-obsession'
    use 'svermeulen/vim-subversive'
    use 'PeterRincker/vim-argumentative'
    use 'dhruvasagar/vim-zoom'
    use 'mbbill/undotree'
    use 'KabbAmine/vCoolor.vim'

    -- Git
    use 'tpope/vim-fugitive'
    use 'junegunn/gv.vim'
    use 'tpope/vim-rhubarb'
    use 'rhysd/git-messenger.vim'

    -- Misc
    use 'xolox/vim-misc'
    use 'moll/vim-bbye'
    use 'dhruvasagar/vim-table-mode'
    use 'godlygeek/tabular'

    -- Lua
    use 'svermeulen/vimpeccable'
    use 'RishabhRD/popfix'
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-telescope/telescope-fzf-writer.nvim'
    use { 'nvim-telescope/telescope-cheat.nvim', requires='tami5/sql.nvim' }
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use 'nvim-telescope/telescope-github.nvim'
    use 'nvim-telescope/telescope-dap.nvim'
    use 'nvim-telescope/telescope-media-files.nvim'
    use 'vijaymarupudi/nvim-fzf'
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use 'nvim-treesitter/nvim-treesitter-textobjects'
    -- use 'tjdevries/nlua.nvim'
    use 'kyazdani42/nvim-web-devicons'
    use 'hoob3rt/lualine.nvim'

    -- LSP
    use 'neovim/nvim-lspconfig'
    use 'RishabhRD/nvim-lsputils'
    use 'glepnir/lspsaga.nvim'
    use 'mfussenegger/nvim-jdtls'
    use 'ray-x/go.nvim'
    use 'simrat39/rust-tools.nvim'
    use 'hrsh7th/nvim-compe'
    use 'mfussenegger/nvim-dap'
    use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }
    use 'theHamsta/nvim-dap-virtual-text'
    use 'mfussenegger/nvim-dap-python'
    use 'ray-x/lsp_signature.nvim'
    use 'norcalli/nvim-colorizer.lua'
    use { 'glacambre/firenvim', run = function() vim.fn['firenvim#install'](0) end }
    use 'tjdevries/vlog.nvim'
    use 'onsails/lspkind-nvim'
    use { 'michaelb/sniprun', run = 'bash ./install.sh'}
    use 'kevinhwang91/rnvimr'
    use 'ryvnf/readline.vim'
    use 'milkypostman/vim-togglelist'
    use "folke/lua-dev.nvim"
    use 'famiu/nvim-reload'
    use 'mizlan/iswap.nvim'
    use 'hashivim/vim-terraform'
    use 'jparise/vim-graphql'
    use 'gennaro-tedesco/nvim-jqx'
    use 'alvarosevilla95/luatab.nvim'
end)

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

require'colorizer'.setup({'*'}, { names = false })

require'compe'.setup {
    enabled = true,
    autocomplete = true,
    debug = false,
    min_length = 1,
    preselect = 'always',
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

require'sniprun'.setup({
    selected_interpreters = { 'Python3_fifo' },
    repl_enable = {'Python3_fifo'},
    repl_disable = {},
    interpreter_options = {},
    display = {
        -- "Classic",
        "Terminal",
        "VirtualTextOk",
        "VirtualTextErr",
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
 -- your personnal icons can go here (to override)
 -- DevIcon will be appended to `name`
 override = {
  telescope = {
    icon = "",
    color = "#428850",
    name = "Telescope"
  }
 };
 -- globally enable default icons (default to false)
 -- will get overriden by `get_icons` option
 default = true;
}
