local install_path = vim.fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.cmd('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
end
vim.cmd 'packadd packer.nvim'

require('packer').startup(function(use)
    use {'wbthomason/packer.nvim', opt = true}
    use 'gruvbox-community/gruvbox'
    -- use {'npxbr/gruvbox.nvim', requires = 'rktjmp/lush.nvim'}
    -- use 'itchyny/lightline.vim'
    -- External tools
    use { 'junegunn/fzf', run = function() vim.fn['fzf#install']() end }
    use 'junegunn/fzf.vim'
    use { 'francoiscabrol/ranger.vim', requires = 'rbgrouleff/bclose.vim' }
    use 'vimwiki/vimwiki'
    use 'lingceng/z.vim'
    use 'benmills/vimux'
    use 'christoomey/vim-run-interactive'
    -- Editing
    use 'norcalli/snippets.nvim'
    use 'tpope/vim-surround'
    use 'tpope/vim-commentary'
    use 'tpope/vim-speeddating'
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
    -- use 'tpope/vim-vinegar'
    -- Lua
    use 'svermeulen/vimpeccable'
    use 'RishabhRD/popfix'
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-telescope/telescope-fzf-writer.nvim'
    use { 'nvim-telescope/telescope-cheat.nvim', requires='tami5/sql.nvim' }
    use 'vijaymarupudi/nvim-fzf'
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
	use { 'nvim-treesitter/nvim-treesitter-textobjects' }
    use 'tjdevries/nlua.nvim'
    use 'kyazdani42/nvim-web-devicons'
    use 'hoob3rt/lualine.nvim'
    -- use 'romgrk/barbar.nvim'
    -- LSP
    use 'neovim/nvim-lspconfig'
    use 'RishabhRD/nvim-lsputils'
    use 'mfussenegger/nvim-jdtls'
    use 'hrsh7th/nvim-compe'
    -- use 'gfanto/fzf-lsp.nvim'
    use 'mfussenegger/nvim-dap'
    use 'theHamsta/nvim-dap-virtual-text'
    use 'mfussenegger/nvim-dap-python'

    use 'norcalli/nvim-colorizer.lua'
    use { 'glacambre/firenvim', run = function() vim.fn['firenvim#install'](0) end }
    use 'tjdevries/vlog.nvim'
end)

vim.cmd 'autocmd BufWritePost plugins.lua PackerCompile'
require'telescope'.load_extension("cheat")
