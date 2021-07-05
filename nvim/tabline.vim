function! CustomTabLine()
    let s = ''
    let t = tabpagenr()
    let i = 1
    while i <= tabpagenr('$')
        let buflist = tabpagebuflist(i)
        let winnr = tabpagewinnr(i)
        let s .= '%' . i . 'T'
        let s .= (i == t ? '%1*' : '%2*')

        let s .= (i == t ? '%#TabNumSel#' : '%#TabNum#')
        let s .= ' ' . i . ' '
        let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')

        let bufnr = buflist[winnr - 1]
        let file = bufname(bufnr)
        let buftype = getbufvar(bufnr, '&buftype')

        if buftype == 'help'
            let file = 'help:' . fnamemodify(file, ':t:r')

        elseif buftype == 'quickfix'
            let file = 'quickfix'

        elseif buftype == 'nofile'
            if file =~ '\/.'
                let file = substitute(file, '.*\/\ze.', '', '')
            endif

        else
            let file = pathshorten(fnamemodify(file, ':p:~:t'))
            let ext = pathshorten(fnamemodify(file, ':e'))
            " let dev = luaeval("require'nvim-web-devicons'.get_icon('".ext."')")
            let dev = luaeval("GetWebIcon('"..file.."', vim.fn.getbufvar("..bufnr..", '&filetype'))")
            let devhl = luaeval("GetWebIconHl('"..file.."', vim.fn.getbufvar("..bufnr..", '&filetype'))")
            if file == 'zsh'
                let dev = luaeval("require'nvim-web-devicons'.get_icon('zsh')")
            endif
            if getbufvar(bufnr, '&modified')
                let file = file  . '[+]'
            endif
            if dev != v:null
                let file = file . ' ' . (i == t ? '%#'..devhl..'#' : '') . dev . (i == t ? '%#TabLineSel#' : '')
            endif

        endif

        if file == ''
            let file = '[No Name]'
        endif

        if file == '[+]'
            let file = '[No Name][+]'
        endif

        let nwins = tabpagewinnr(i, '$')
        if nwins > 1
            let modified = ''
            for b in buflist
                if getbufvar(b, '&modified') && b != bufnr
                    let modified = '*'
                    break
                endif
            endfor
            let hl = (i == t ? '%#WinNumSel#' : '%#WinNum#')
            let nohl = (i == t ? '%#TabLineSel#' : '%#TabLine#')
            " let s .= ' ' . modified . '(' . winnr . '/' . nwins . ')'
            let s .= '' . modified . '(' . nwins . ')'
        endif

        let s .= ' ' . file


        if i < tabpagenr('$')
            let s .= ' %#TabLine#|'
        else
            let s .= ' '
        endif

        let i = i + 1

    endwhile

    let s .= '%T%#TabLineFill#%='
    " let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
    return s

endfunction

" set showtabline=1
highlight! TabNum term=bold cterm=bold ctermfg=1 ctermbg=7 gui=bold 
highlight! TabNumSel term=bold,reverse cterm=bold,reverse ctermfg=1 ctermbg=7 gui=bold
highlight! WinNum term=bold cterm=bold ctermfg=11 ctermbg=7 
highlight! WinNumSel term=bold cterm=bold ctermfg=7 ctermbg=14 

" set tabline=%!CustomTabLine()
