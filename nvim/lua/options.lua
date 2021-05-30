local opt = vim.opt
opt.termguicolors  = true;
opt.updatetime     = 100;
opt.splitright     = true;
opt.hidden         = true;
opt.wildmenu       = true;
opt.showcmd        = true;
opt.hlsearch       = true;
opt.ignorecase     = true;
opt.smartcase      = true;
opt.backspace      = 'indent,eol,start';
opt.ruler          = true;
opt.laststatus     = 2
opt.confirm        = true;
opt.visualbell     = true;
opt.mouse          = 'a';
opt.timeout        = false
opt.ttimeout       = true;
opt.ttimeoutlen    = 0;
opt.pastetoggle    = '<F11>';
opt.clipboard      = 'unnamed';
opt.showmode       = false;
opt.autowrite      = true;
opt.wildmode       = 'longest,full';
opt.foldlevel      = 2;
opt.shortmess      = 'IOc';
opt.completeopt    = 'menuone,noselect'; -- 'menuone,noinsert,noselect';
opt.tabstop        = 4;
opt.shiftwidth     = 4;
opt.softtabstop    = 4;
opt.expandtab      = true;
opt.cursorline     = true;
opt.relativenumber = true;
opt.number         = true;
opt.signcolumn     = 'no';
opt.autoindent     = true;
opt.expandtab      = true;
opt.tabstop        = 4;
opt.shiftwidth     = 4;
opt.softtabstop    = 4;
opt.grepprg='rg --vimgrep --no-heading --smart-case'
opt.grepformat='%f:%l:%c:%m,%f:%l:%m'

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
    vsnip = true;
    nvim_lsp = true;
    nvim_lua = true;
    spell = true;
    tags = true;
    treesitter = true;
  };
}

require('lualine').setup{
    options = {
        theme = 'gruvbox_light'
    },
    sections = {
        lualine_a = {'mode'},
        -- lualine_b = {'branch'},
        lualine_b = {'Cwd()'},
        lualine_c = {'filename'},
        -- lualine_c = {'Cwd()', 'filename'},
        -- lualine_c = {'branch', 'filename'},
        lualine_x = {'filetype', 'branch'},
        -- lualine_x = {'encoding', 'fileformat', 'filetype'},
        -- lualine_x = {'Cwd()', 'fileformat', 'filetype'},
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
