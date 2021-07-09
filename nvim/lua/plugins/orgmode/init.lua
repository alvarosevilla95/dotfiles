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
    org_default_notes_file = '~/Dropbox/org/capture.org',
    org_agenda_templates = {
        t = { description = 'Task', template = '* TODO %?\n  %u - <unrefiled>' },
        n = { description = 'Note', template = '* NOTE %?\n  %u - <unrefiled>' },
        r = { description = 'Read', template = '* NOTE %?\n  %u - <unrefiled>' },
        w = { description = 'Work', template = '* TODO (WORK) %?\n  %u - <unrefiled>', target = '~/Dropbox/org/work.org' },
    },
    mappings = {
        agenda = {
            org_agenda_later = 'f',
            org_agenda_earlier = 'b',
            org_agenda_goto_today = '.',
            org_agenda_day_view = 'vd',
            org_agenda_week_view = 'vw',
            org_agenda_month_view = 'vm',
            org_agenda_year_view = 'vy',
            org_agenda_quit = 'q',
            org_agenda_switch_to = '<CR>',
            org_agenda_goto = {'<TAB>'},
            org_agenda_goto_date = 'J',
            org_agenda_redo = 'r',
            org_agenda_show_help = '?',
        },
        capture = {
            org_capture_finalize = '<Leader>ok',
            org_capture_refile = '<Leader>ol',
            org_capture_kill = '<Leader>oK',
            org_capture_show_help = '?',
        },
        org = {
            org_refile = '<Leader>ol',
            org_increase_date = '<C-a>',
            org_decrease_date = '<C-x>',
            org_change_date = 'cid',
            org_todo = 'cit',
            org_todo_prev = 'ciT',
            org_toggle_checkbox = '<C-Space>',
            org_open_at_point = '<Leader>oo',
            org_cycle = '<TAB>',
            org_global_cycle = '<S-TAB>',
            org_archive_subtree = '<Leader>o$',
            org_set_tags_command = '<Leader>ot',
            org_toggle_archive_tag = '<Leader>oA',
            org_do_promote = '<<',
            org_do_demote = '>>',
            org_promote_subtree = '<s',
            org_demote_subtree = '>s',
            org_meta_return = '<Leader><CR>', -- Add headling, item or row
            org_insert_heading_respect_content = '<Leader>oih', -- Add new headling after current heading block with same level
            org_insert_todo_heading = '<Leader>oiT', -- Add new todo headling right after current heading with same level
            org_insert_todo_heading_respect_content = '<Leader>oit', -- Add new todo headling after current heading block on same level
            org_move_subtree_up = '<Leader>oK',
            org_move_subtree_down = '<Leader>oJ',
            org_show_help = '?',
        }
    },
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
                lnum = tonumber(vim.fn.split(line, ':')[2]),
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
                    require("orgmode").action("capture.refile_headline_to_selection", {
                        file = entry.path:gsub('.*/', ''),
                        target = entry.lnum,
                    })
                    return true
                end
            end)
            return true
        end,
    }:find()
end

local function get_line_headline()
    local file = require("orgmode.parser.files").get_current_file()
    return file:get_closest_headline()
end

function Headline_up()
    local lnum = vim.fn.line('.')
    local headline = get_line_headline()
    if headline.id ~= lnum then
        vim.cmd(f'{headline.id}')
        return
    end
    local pid = headline.parent.id
    if pid > 0 then
        print('')
        vim.cmd(f'{pid}')
    end
end

function Headline_down()
    local headline = get_line_headline()
    if lib.size(headline.headlines) == 0 then
        return
    end
    vim.cmd(f'{headline.headlines[1].id}')
end

function Headline_prev()
    local headline = get_line_headline()
    local prev = headline:get_prev_headline_same_level()
    if prev then
        vim.cmd(f'{prev.id}')
    end
end

function Headline_next()
    local headline = get_line_headline()
    local next = headline:get_next_headline_same_level()
    if next then
        vim.cmd(f'{next.id}')
    end
end
