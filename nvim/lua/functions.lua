local fzf = require("fzf").fzf
local action = require "fzf.actions".action
local pickers = require'telescope.pickers'
local sorters = require'telescope.sorters'
local finders = require'telescope.finders'
local previewers = require'telescope.previewers'
local actions = require'telescope.actions'
local from_entry = require'telescope.from_entry'
local actions_set = require'telescope.actions.set'
local utils = require'telescope.utils'
local putils = require('telescope.previewers.utils')

function RipgrepFzf(dir)
    dir = dir or './'
    local command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
    local initial_command = string.format(command_fmt, '"" ' .. dir)
    local reload_command = string.format(command_fmt, '{q} ' .. dir)
    local spec = { options = {'--phony', '--query', '', '--bind', 'change:reload:' .. reload_command} }
    print(f'{spec}')
    vim.fn['fzf#vim#grep'](initial_command, 1, vim.fn['fzf#vim#with_preview'](spec), 0)
end

local cdAction = function(prompt_bufnr)
    actions_set.select:replace(function(_, type)
        local entry = actions.get_selected_entry()
        actions.close(prompt_bufnr)
        local dir = from_entry.path(entry)
        vim.cmd('cd '..dir)
    end)
    return true
end

function Cd(path)
    path = path or '.'
    local cmd = {vim.o.shell, '-c', "fd . "..path.." --type=d 2>/dev/null"}
    pickers.new({}, {
        prompt_title = 'Cd',
        finder = finders.new_table{ results = utils.get_os_command_output(cmd) },
        previewer = previewers.vim_buffer_cat.new({}),
        sorter = sorters.get_fuzzy_file(),
        attach_mappings = cdAction,
    }):find()
end

function Cdz()
    local cmd = {vim.o.shell, '-c', "cat ~/.z | cut -d '|' -f1"}
    pickers.new({}, {
        prompt_title = 'z directories',
        finder = finders.new_table{ results = utils.get_os_command_output(cmd) },
        previewer = previewers.vim_buffer_cat.new({}),
        sorter = sorters.get_fuzzy_file(),
        attach_mappings = cdAction,
    }):find()
end

function SshPicker()
    local cmd = {vim.o.shell, '-c', "cat ~/.ssh/known_hosts|cut -f1 -d ' ' |cut -f1 -d ,"}
    pickers.new({}, {
        prompt_title = 'ssh hosts',
        finder = finders.new_table{ results = utils.get_os_command_output(cmd) },
        sorter = sorters.get_fuzzy_file(),
        attach_mappings = function(prompt_bufnr)
            actions_set.select:replace(function(_, type)
                local entry = actions.get_selected_entry()
                actions.close(prompt_bufnr)
                local res = from_entry.path(entry)
                if type == 'default' then
                    vim.cmd('term ssh '..res)
                elseif type == 'horizontal' then
                    vim.cmd('top sp | term ssh '..res)
                elseif type == 'vertical' then
                    vim.cmd('vsp | term ssh '..res)
                elseif type == 'tab' then
                    vim.cmd('silent ! echo '..res..' | pbcopy')
                end
            end)
            return true
        end,
    }):find()
end

function PsqlPicker()
    local cmd = {vim.o.shell, '-c', "cat ~/.postgres_hosts"}
    pickers.new({}, {
        prompt_title = 'SQL hosts',
        finder = finders.new_table{ results = utils.get_os_command_output(cmd) },
        sorter = sorters.get_fuzzy_file(),
        attach_mappings = function(prompt_bufnr)
            actions_set.select:replace(function(_, type)
                local entry = actions.get_selected_entry()
                actions.close(prompt_bufnr)
                local res = from_entry.path(entry)
                res = vim.fn.split(res, ' ')[2]
                if type == 'default' then
                    print('term psql '..res)
                    vim.cmd('term psql '..res)
                elseif type == 'horizontal' then
                    vim.cmd('top sp | term psql '..res)
                elseif type == 'vertical' then
                    vim.cmd('vsp | term psql '..res)
                elseif type == 'tab' then
                    vim.cmd('silent ! echo '..res..' | pbcopy')
                end
            end)
            return true
        end,
    }):find()
end

function K8sPods()
    local cmd = {vim.o.shell, '-c', "kubectl get pods | cut -d ' ' -f1 | tail -n +2"}
    pickers.new({}, {
        prompt_title = 'K8s Pods',
        finder = finders.new_table{
            results = utils.get_os_command_output(cmd),
        },
        sorter = sorters.get_fuzzy_file(),
        previewer = previewers.new_buffer_previewer {
            get_buffer_by_name = function(_, entry)
                return entry.value
            end,

            define_preview = function(self, entry)
                local command =  { 'kubectl', 'get', 'pod', '-o', 'yaml', entry.value }
                putils.job_maker(command, self.state.bufnr, {
                    value = entry.value,
                    bufname = self.state.bufname,
                })
                putils.regex_highlighter(self.state.bufnr, "yaml")
            end
        },
        attach_mappings = function(prompt_bufnr)
            actions_set.select:replace(function(_, type)
                local entry = actions.get_selected_entry()
                actions.close(prompt_bufnr)
                local res = from_entry.path(entry)
                if type == 'default' then
                    vim.cmd("term kubectl logs -f " .. res)
                elseif type == 'horizontal' then
                    vim.cmd("top sp | term kubectl logs -f " .. res)
                elseif type == 'vertical' then
                    vim.cmd("vsp | enew")
                    vim.cmd("set ft=yaml")
                    vim.cmd("r! kubectl get pod -o yaml " .. res)
                    vim.cmd("norm! ggdd0")
                elseif type == 'tab' then
                    vim.cmd('silent ! echo ' .. res .. ' | pbcopy')
                end
            end)
            return true
        end,
    }):find()
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

function cwd()
    return vim.fn.fnamemodify(vim.fn.getcwd(), ':~')
end

function Gclone(repo, dest)
    dest = ' /Users/alvaro/Developer/'..dest
    vim.cmd('G clone git@github.com:'..repo..dest)
    vim.cmd('cd'..dest)
end
