local install_path = vim.fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.cmd('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
end
vim.cmd 'packadd packer.nvim'
vim.cmd 'autocmd BufWritePost plugins.lua PackerCompile'
require('packer').startup(function(use)
    use {'wbthomason/packer.nvim', opt = true}
    -- use { 'npxbr/gruvbox.nvim', requires = {"rktjmp/lush.nvim"}}
    use 'gruvbox-community/gruvbox'

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
    use 'famiu/nvim-reload'
    use 'mizlan/iswap.nvim'
    use 'hashivim/vim-terraform'
    use 'jparise/vim-graphql'
    use 'gennaro-tedesco/nvim-jqx'
    use 'alvarosevilla95/luatab.nvim'
    use 'kristijanhusak/orgmode.nvim'
    use 'nvim-telescope/telescope-project.nvim'
    use 'folke/trouble.nvim'
    use 'simrat39/symbols-outline.nvim'
end)

require'plugins.config'
require'plugins.telescope'
require'plugins.orgmode'
