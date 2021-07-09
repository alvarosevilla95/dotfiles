function RipgrepFzf(dir)
    dir = dir or './'
    local command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
    local initial_command = string.format(command_fmt, '"" ' .. dir)
    local reload_command = string.format(command_fmt, '{q} ' .. dir)
    local spec = { options = {'--phony', '--query', '', '--bind', 'change:reload:' .. reload_command} }
    print(f'{spec}')
    vim.fn['fzf#vim#grep'](initial_command, 1, vim.fn['fzf#vim#with_preview'](spec), 0)
end

function SearchGoogle(query)
    vim.cmd(string.format("!open 'http://google.com/search?query=%s'", lib.urlencode(query)))
end

function StopLSP()
    vim.lsp.stop_client(vim.lsp.get_active_clients())
end

function Cwd()
    return vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
end

function Clone(repo)
    local name = vim.fn.split(repo, '/')[2]
    vim.cmd(f'! gh repo clone {repo} ~/Developer/{name}')
    vim.cmd(f'cd ~/Developer/{name}')
end

function PandocOpen(file, ext)
    local tmpfile= vim.fn.system(f'mktemp /tmp/$(uuidgen).{ext}'):gsub("\n", "")
    vim.fn.system(f'pandoc {file} -o {tmpfile}')
    vim.fn.system(f'open -a Firefox {tmpfile}')
end

function TC()
    if vim.env.BC == 'dark' then
        vim.fn.system('toggle_colors_light')
        vim.env.BC= 'light'
        require('lualine').setup{
            options = {
                theme = 'gruvbox-light'
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
    else
        vim.fn.system('toggle_colors_dark')
        vim.env.BC= 'dark'
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
    end
    vim.cmd 'source ~/dotfiles/nvim/colors.vim'
end
