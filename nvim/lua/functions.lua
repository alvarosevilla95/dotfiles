
function RipgrepFzf(dir)
    dir = dir or './'
    local command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
    local initial_command = string.format(command_fmt, '"" ' .. dir)
    local reload_command = string.format(command_fmt, '{q} ' .. dir)
    local spec = { options = {'--phony', '--query', '', '--bind', 'change:reload:' .. reload_command} }
    print(f'{spec}')
    vim.fn['fzf#vim#grep'](initial_command, 1, vim.fn['fzf#vim#with_preview'](spec), 0)
end

local function urlencode(url)
    local char_to_hex = function(c)
        return string.format("%%%02X", string.byte(c))
    end
    if url == nil then
        return
    end
    url = url:gsub("\n", "\r\n")
    url = url:gsub("([^%w ])", char_to_hex)
    url = url:gsub(" ", "+")
    return url
end

function SearchGoogle(query)
    vim.cmd(string.format("!open 'http://google.com/search?query=%s'", urlencode(query)))
end

function StopLSP()
    vim.lsp.stop_client(vim.lsp.get_active_clients())
end

function Cwd()
    return vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
end

function Gclone(repo, dest)
    dest = ' /Users/alvaro/Developer/'..dest
    vim.cmd('G clone git@github.com:'..repo..dest)
    vim.cmd('cd'..dest)
end
vim.cmd [[ command! -nargs=+ Gclone lua Gclone(<f-args>) ]]

function iprint(obj)
    print(vim.inspect(obj))
end
