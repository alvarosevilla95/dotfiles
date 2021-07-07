local actions = require('telescope.actions')
local pickers = require'telescope.pickers'
local sorters = require'telescope.sorters'
local previewers = require'telescope.previewers'
local actions_set = require'telescope.actions.set'
local action_state = require('telescope.actions.state')
local finders = require'telescope.finders'
local utils = require'telescope.utils'

require('orgmode').setup {
    org_agenda_files = {'~/Dropbox/org/*'},
    org_default_notes_file = '~/Dropbox/org/agenda.org',
    mappings = {
        -- disable_all = true,
        capture = {
            org_capture_refile = '<leader>ol',
        },
        org = {
            org_refile = '<Leader>ol',
        }
    },
    org_agenda_templates = {
        t = { description = 'Task', template = '* TODO %?\n  %u' },
        n = { description = 'Note', template = '* %?', target = '~/Dropbox/org/agenda.org'},
        r = { description = 'Read',  template = '* READ: %?' },

    }
}

local function orgFileFinder()
    local cmd = {vim.o.shell, '-c', "fd . ~/Dropbox/org/ --type=f 2>/dev/null"}
    local entry_display = require'telescope.pickers.entry_display'
    local displayer = entry_display.create{ items = { { remaining = true } }, }
    return finders.new_table{
        results = utils.get_os_command_output(cmd),
        entry_maker = function(line)
            local display = function(entry)
                return displayer({entry.path:gsub('.*/', '')})
            end
            return {
                value = line,
                ordinal = line,
                path = line,
                display = display,
            }
        end,
    }
end

function WikiPicker()
    pickers.new({}, {
        prompt_title = 'Org files',
        finder = orgFileFinder(),
        previewer = previewers.vim_buffer_cat.new({}),
        sorter = sorters.get_fuzzy_file(),
        attach_mappings = function(prompt_bufnr)
            actions_set.select:replace(function(_, type)
                if type == 'ctrl-l' then
                    local res = action_state.get_current_line()
                    actions.close(prompt_bufnr)
                    vim.cmd('edit ~/Dropbox/org/' .. res .. '.org')
                    return true
                end
                local ek = action_state.select_key_to_edit_key(type)
                return actions_set.edit(prompt_bufnr, ek)
            end)
            return true
        end,
    }):find()
end


local function grepEntryFinder(cmd)
    local entry_display = require'telescope.pickers.entry_display'
    local displayer = entry_display.create{ items = { { remaining = true } }, }
    return finders.new_table{
        results = utils.get_os_command_output(cmd),
        entry_maker = function(line)
            local display = function(line, short)
                local pathp = line:gmatch('/[^/:]+:')()
                local headline = line:gsub('^.*:[0-9]+:[0-9]+:', '')
                return not short and displayer({pathp:sub(2) .. ' ' .. headline}) or displayer({headline})

            end
            return {
                value = line,
                ordinal = display(line, true),
                path = line:gsub(':.*$', ''),
                lnum = tonumber(split(line, ':')[2]),
                disp = display(line, false),
                display = function(entry) return entry.disp end,
            }
        end,
    }
end

function GetHeadlines()
    local cmd = {vim.o.shell, '-c', "rg '^\\*+' ~/Dropbox/org --vimgrep"}
    pickers.new{
        prompt_title = 'Headlines',
        finder = grepEntryFinder(cmd),
        previewer = previewers.vim_buffer_vimgrep.new({}),
        sorter = sorters.get_fuzzy_file(),
        attach_mappings = function(prompt_bufnr)
            actions_set.select:replace(function(_, type)
                if type == 'ctrl-l' then
                    local entry = actions.get_selected_entry()
                    actions.close(prompt_bufnr)
                    local res = entry.disp:gsub('^[^:]+:%s[*]+ ', '[[*') .. ']]'
                    vim.cmd('silent norm! a' .. res)
                    return true
                end
                local ek = action_state.select_key_to_edit_key(type)
                return actions_set.edit(prompt_bufnr, ek)
            end)
            return true
        end,
    }:find()
end

function RefileHeadline()
    local cmd = {vim.o.shell, '-c', "rg '^\\*+' ~/Dropbox/org --vimgrep"}
    pickers.new{
        prompt_title = 'Refile',
        finder = grepEntryFinder(cmd),
        previewer = previewers.vim_buffer_vimgrep.new({}),
        sorter = sorters.get_fuzzy_file(),
        attach_mappings = function(prompt_bufnr)
            actions_set.select:replace(function(_, type)
                if type == 'default' then
                    local entry = actions.get_selected_entry()
                    actions.close(prompt_bufnr)
                    require("orgmode").action("capture.refile_headline_to_destination_set", {
                        file = entry.path,
                        target = entry.lnum,
                    })
                    return true
                end
            end)
            return true
        end,
    }:find()
end
