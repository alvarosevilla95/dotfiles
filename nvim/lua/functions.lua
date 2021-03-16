local fzf = require("fzf").fzf
local action = require "fzf.actions".action


function RipgrepFzf(dir)
    dir = dir or './'
    local command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
    local initial_command = string.format(command_fmt, '"" ' .. dir)
    local reload_command = string.format(command_fmt, '{q} ' .. dir)
    local spec = { options = {'--phony', '--query', '', '--bind', 'change:reload:' .. reload_command} }
    print(f'{spec}')
    vim.fn['fzf#vim#grep'](initial_command, 1, vim.fn['fzf#vim#with_preview'](spec), 0)
end

local base_opts = '--height 100% '
local preview_opts = base_opts .. '--preview '

local exa_preview = function(items, fzf_lines, fzf_cols)
    return vim.fn.systemlist ('exa -l --color=always ' .. items[1])
end

function Cd(path)
    path = path or '.'
    coroutine.wrap(function()
        local cmd = string.format("fd . %s --type=d 2>/dev/null", path)
        local res = fzf(cmd, preview_opts .. action(exa_preview))[1]
        vim.cmd("cd " .. res)
    end)()
end

function Cdz()
    coroutine.wrap(function()
        local res = fzf("cat ~/.z | cut -d '|' -f1", preview_opts .. action(exa_preview))[1]
        vim.cmd("cd " .. res)
    end)()
end

local pr_preview = function(items, fzf_lines, fzf_cols)
    return vim.fn.systemlist ('gh pr view ' .. string.match(items[1], '^[0-9]+'))
end

function Prs()
    coroutine.wrap(function()
        local res = fzf("gh pr list", preview_opts .. action(pr_preview))[1]
        vim.cmd("cd " .. res)
    end)()
end


local char_to_hex = function(c)
    return string.format("%%%02X", string.byte(c))
end

function urlencode(url)
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
