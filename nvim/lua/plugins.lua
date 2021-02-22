local install_path = vim.fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.cmd('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
end
vim.cmd 'packadd packer.nvim'

require('packer').startup(function()
    use {'wbthomason/packer.nvim', opt = true}
    use 'gruvbox-community/gruvbox'
    -- use {'npxbr/gruvbox.nvim', requires = 'tjdevries/colorbuddy.nvim'}
    use 'itchyny/lightline.vim'
    -- External tools
    use { 'junegunn/fzf', run = function() vim.fn['fzf#install']() end }
    use 'junegunn/fzf.vim'
    use { 'yuki-ycino/fzf-preview.vim', branch = 'release/remote', run = ':UpdateRemotePlugins' }
    use { 'francoiscabrol/ranger.vim', requires = 'rbgrouleff/bclose.vim' }
    use 'vimwiki/vimwiki'
    use 'lingceng/z.vim'
    use 'benmills/vimux'
    use 'christoomey/vim-run-interactive'
    -- Editing
    use 'sirver/ultisnips'
    use 'honza/vim-snippets'
    use 'tpope/vim-surround'
    use 'tpope/vim-commentary'
    use 'tpope/vim-speeddating'
    use 'svermeulen/vim-yoink'
    use 'tpope/vim-unimpaired'
    use 'tpope/vim-repeat'
    use 'svermeulen/vim-subversive'
    use 'dhruvasagar/vim-zoom'
    use 'mbbill/undotree'
    use 'KabbAmine/vCoolor.vim'
    -- Git
    use 'tpope/vim-fugitive'
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
    use 'vijaymarupudi/nvim-fzf'
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
	use { 'nvim-treesitter/nvim-treesitter-textobjects' }
    -- LSP
    use 'neovim/nvim-lspconfig'
    use 'RishabhRD/nvim-lsputils'
    use 'mfussenegger/nvim-jdtls'
    use 'nvim-lua/completion-nvim'
    use 'gfanto/fzf-lsp.nvim'

    use 'norcalli/nvim-colorizer.lua'
end)

vim.cmd 'autocmd BufWritePost plugins.lua PackerCompile'
