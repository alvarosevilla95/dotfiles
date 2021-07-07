local actions = require('telescope.actions')
local pickers = require'telescope.pickers'
local sorters = require'telescope.sorters'
local finders = require'telescope.finders'
local previewers = require'telescope.previewers'
local from_entry = require'telescope.from_entry'
local actions_set = require'telescope.actions.set'
local utils = require'telescope.utils'
local putils = require('telescope.previewers.utils')
local action_set = require('telescope.actions.set')
local action_state = require('telescope.actions.state')

local function action_edit_ctrl_l(prompt_bufnr)
    return action_set.select(prompt_bufnr, "ctrl-l")
end

local function action_edit_ctrl_r(prompt_bufnr)
    return action_set.select(prompt_bufnr, "ctrl-r")
end


require('telescope').setup {
    defaults = {
        layout_config = {
            prompt_position = "top",
        },
        sorting_strategy = "ascending",
        mappings = {
            i = {
                ["<C-u>"] = false,
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<CR>" ] = actions.select_default + actions.center,
                ["<C-s>"] = actions.select_horizontal,
                ["<esc>"] = actions.close,
                ["<C-l>"] = action_edit_ctrl_l,
                ["<C-r>"] = action_edit_ctrl_r,
            },
            n = {
                ["<esc>"] = actions.close,
            },
        },
    },
    extensions = {
        fzf = {
            fuzzy = true,                    -- false will only do exact matching
            override_generic_sorter = false, -- override the generic sorter
            override_file_sorter = true,     -- override the file sorter
            case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        },
        fzf_writer = {
            minimum_grep_characters = 2,
            minimum_files_characters = 0,
            use_highlighter = true,
        },
    }
}

require('telescope').load_extension('fzf')
require('telescope').load_extension('gh')
require('telescope').load_extension('dap')

-- Custom pickers
local cdPicker = function(name, cmd)
    pickers.new({}, {
        prompt_title = name,
        finder = finders.new_table{ results = utils.get_os_command_output(cmd) },
        previewer = previewers.vim_buffer_cat.new({}),
        sorter = sorters.get_fuzzy_file(),
        attach_mappings = function(prompt_bufnr)
            actions_set.select:replace(function(_, type)
                local entry = actions.get_selected_entry()
                actions.close(prompt_bufnr)
                local dir = from_entry.path(entry)
                vim.cmd('cd '..dir)
            end)
            return true
        end,
    }):find()
end

function Cd(path)
    path = path or '.'
    cdPicker('Cd', {vim.o.shell, '-c', "fd . "..path.." --type=d 2>/dev/null"})
end

function Cdz()
    cdPicker('z directories', {vim.o.shell, '-c', "cat ~/.z | cut -d '|' -f1"})
end

function SshPicker(tmux)
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
                local sshCmd = 'term ssh '..res
                if tmux then
                    sshCmd = sshCmd..' -t tmux a || tmux'
                end
                if type == 'default' then
                    vim.cmd(sshCmd)
                elseif type == 'horizontal' then
                    vim.cmd('sp | '..sshCmd)
                elseif type == 'vertical' then
                    vim.cmd('vsp | '..sshCmd)
                elseif type == 'tab' then
                    vim.cmd('silent ! echo '..res..' | pbcopy')
                end
            end)
            return true
        end,
    }):find()
end
vim.cmd [[ command! Ssh lua SshPicker() ]]


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
vim.cmd [[ command! Psql lua PsqlPicker() ]]

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
                    vim.cmd("norm! G")
                elseif type == 'horizontal' then
                    vim.cmd("top sp | term kubectl logs -f " .. res)
                    vim.cmd("norm! G")
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
vim.cmd [[ command! K8s lua K8sPods() ]]

function FFHistoryPicker()
    local dbPath = '/Users/alvaro/Library/Application\\ Support/Firefox/Profiles/52hn3b6n.default-release/places.sqlite'
    local tmpfile=vim.fn.system('mktemp /tmp/ffhist.XXXXX'):gsub("\n", "")
    vim.fn.system('cp ' .. dbPath .. ' ' .. tmpfile)
    local sep="∙"
    local query = [[
    SELECT
    url, title FROM moz_places
    WHERE
    url NOT LIKE '%google%search%'
    ORDER BY
    visit_count DESC,
    last_visit_date DESC;
    ]]

    local cmd = {vim.o.shell, '-c', f[[sqlite3 "{tmpfile}" "{query}" | sed -E "s/^https?:\/\///" | sed -E "s/\\/?\\|/ {sep} /" | sed -E "s/{sep} $//"]]}
    pickers.new({}, {
        prompt_title = 'Firefox History',
        finder = finders.new_table{ results = utils.get_os_command_output(cmd) },
        sorter = sorters.get_fuzzy_file(),
        attach_mappings = function(prompt_bufnr)
            actions_set.select:replace(function(_, type)
                local entry = actions.get_selected_entry()
                actions.close(prompt_bufnr)
                local res = from_entry.path(entry)
                res = vim.fn.split(res, ' '..sep)[1]
                if type == 'default' then
                    vim.cmd('silent ! open "http://'..res..'"')
                end
            end)
            return true
        end,
    }):find()
end
vim.cmd [[ command! Psql lua PsqlPicker() ]]
