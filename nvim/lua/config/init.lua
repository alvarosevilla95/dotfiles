-- Neovim configuraion

-- Auto install packer
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.api.nvim_command('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
    vim.api.nvim_command 'packadd packer.nvim'
end

vim.cmd [[packadd packer.nvim]]
require('packer').startup(function()
    use {'wbthomason/packer.nvim', opt = true}
    use 'gruvbox-community/gruvbox'
    use 'itchyny/lightline.vim'
    -- External tools
    use { 
        'junegunn/fzf',
        run = function() vim.fn['fzf#install']() end 
    }
    use 'junegunn/fzf.vim'
    use { 
        'yuki-ycino/fzf-preview.vim',
        branch = 'release/remote',
        run = ':UpdateRemotePlugins' 
    }
    use { 
        'francoiscabrol/ranger.vim',
        requires = 'rbgrouleff/bclose.vim' 
    }
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
    -- LSP
    use 'neovim/nvim-lspconfig'
    use 'RishabhRD/nvim-lsputils'
    use 'mfussenegger/nvim-jdtls'
    use { 
        'Shougo/deoplete.nvim', 
        run = ':UpdateRemotePlugins' 
    }
    use 'deoplete-plugins/deoplete-lsp'
    use 'gfanto/fzf-lsp.nvim'
    use { 
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate' 
    }
end)

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

vim.g.vimwiki_list = {{ syntax = 'markdown', ext = '.md', path = '/Users/alvaro/Dropbox/wiki/'}}
vim.g.vimwiki_global_ext = 0
vim.g.vimwiki_ext2syntax = {['.md'] = 'markdown',['.markdown'] = 'markdown', ['.mdown'] = 'markdown'}

vim.g.git_messenger_no_default_mappings = true

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
