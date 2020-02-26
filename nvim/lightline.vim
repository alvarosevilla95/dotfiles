function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction
function! NearestMethodOrFunction() abort
      return get(b:, 'vista_nearest_method_or_function', '')
endfunction
set statusline+=%{NearestMethodOrFunction()}
let g:lightline = {
            \ 'colorscheme': 'gruvbox',
            \ 'active': {
            \   'left':  [[ 'mode', 'paste' ], ['fugitive'], ['filename'], ['method']],
            \   'right': [['lineinfo'], ['percent'], ['filetype'], ['cocstatus']]
            \ },
            \ 'component_function': {
            \   'fugitive': 'LightlineFugitive',
            \   'modified': 'LightlineModified',
            \   'cocstatus': 'StatusDiagnostic',
            \   'currentfunction': 'CocCurrentFunction',
            \   'method': 'NearestMethodOrFunction'
            \ }
            \ }
function! LightlineModified()
    if &filetype == "help"
        return ""
    elseif &modified
        return "+"
    elseif &modifiable
        return ""
    else
        return ""
    endif
endfunction
function! LightlineFugitive()
    return exists('*fugitive#head') ? fugitive#head() : ''
endfunction

