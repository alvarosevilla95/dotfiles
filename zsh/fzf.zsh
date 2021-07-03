export FZF_DEFAULT_COMMAND='fd --type f --color=never'
export FZF_DEFAULT_OPTS=" --height 40% --bind ctrl-o:toggle-all  --reverse
--color=bg+:$color01,bg:$color00,spinner:$color0C,hl:$color0D
--color=fg:$color04,header:$color0D,info:$color0A,pointer:$color0C
--color=marker:$color0C,fg+:$color06,prompt:$color0A,hl+:$color0D "
export FZF_ALT_C_COMMAND='fd --type d . --color=never'
export FZF_ALT_C_OPTS='--preview="exa {} -l --color=always"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS='--preview="bat {} --style=\"full\" --color=always 2>/dev/null || exa {} -l --color=always" --preview-window '~3''
export FZF_COMPLETION_OPTS='--preview="bat {} --style=\"full\" --color=always 2>/dev/null || exa {} -l --color=always" --preview-window '~3''
export PATH="$PATH:/home/alvaro/.fzf/bin"

FZF_TAB_COMMAND=(
    fzf
    --ansi   # Enable ANSI color support, necessary for showing groups
    --expect='$continuous_trigger' # For continuous completion
    '--color=hl:$(( $#headers == 0 ? 108 : 255 ))'
    --nth=2,3 --delimiter='\x00'  # Don't search prefix
    --layout=reverse --height='${FZF_TMUX_HEIGHT:=75%}'
    --tiebreak=begin -m --bind=tab:down,btab:up,change:top,ctrl-s:toggle --cycle
    '--query=$query'   # $query will be expanded to query string at runtime.
    '--header-lines=$#headers' # $#headers will be expanded to lines of headers at runtime
)
zstyle ':fzf-tab:*' command $FZF_TAB_COMMAND

source "/Users/alvaro/.fzf/shell/completion.zsh" 2> /dev/null
source "/Users/alvaro/.fzf/shell/key-bindings.zsh"
bindkey "^G" fzf-dir-widget
bindkey "^F" fzf-file-widget

function  _fzf_compgen_path() {
    command fd --type f --color=never
}
function  _fzf_compgen_dir() {
    command fd --type d --color=never
}

fzf_dir() {
    echo "$(_fzf_compgen_dir | fzf --height 40% --preview='exa {} -lh --color=always')"
}

fzf-dir-widget () {
LBUFFER="${LBUFFER}$(__fdir)"
local ret=$?
zle reset-prompt
return $ret
}

__fdir () {
    local cmd="_fzf_compgen_dir"
    setopt localoptions pipefail no_aliases 2> /dev/null
    local item
    eval "$cmd" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse --bind=ctrl-z:ignore $FZF_DEFAULT_OPTS $FZF_ALT_C_OPTS" $(__fzfcmd) -m "$@" | 
        while read item
        do
            echo -n "${(q)item} "
        done
        local ret=$?
        echo
        return $ret
    }

zle -N fzf-dir-widget

fzf_z() {
    if [[ -z "$*" ]]; then
        cd "$(_z -l 2>&1 | sed 's/^[0-9,.]* *//' | fzf --height 40% --preview='exa {} -lh --color=always')"
    else
        _last_z_args="$@"
        _z "$@"
    fi
}

