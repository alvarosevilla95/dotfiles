local color00='#282828'
local color01='#3c3836'
local color02='#504945'
local color03='#665c54'
local color04='#bdae93'
local color05='#d5c4a1'
local color06='#ebdbb2'
local color07='#fbf1c7'
local color08='#fb4934'
local color09='#fe8019'
local color0A='#fabd2f'
local color0B='#b8bb26'
local color0C='#8ec07c'
local color0D='#83a598'
local color0E='#d3869b'
local color0F='#d65d0e'

export FZF_TMUX=1
export FZF_TMUX_HEIGHT="40%"
export FZF_DEFAULT_COMMAND='fd --type f --color=never'
export FZF_DEFAULT_OPTS="
  --height 40% --bind ctrl-o:toggle-all --color=bg+:$color01,bg:$color00,spinner:$color0C,hl:$color0D
  --color=fg:$color04,header:$color0D,info:$color0A,pointer:$color0C
  --color=marker:$color0C,fg+:$color06,prompt:$color0A,hl+:$color0D
"
export FZF_ALT_C_COMMAND='fd --type d . --color=never'
export FZF_ALT_C_OPTS='--preview="exa {} -l --color=always"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS='--preview="bat {} --theme="base16" --color=always --style=\"numbers\""'
export FZF_COMPLETION_OPTS='--preview="bat {} --theme="base16" --style=\"numbers\" --color=always 2>/dev/null || exa {} -l --color=always"'
export PATH="$PATH:/home/alvaro/.fzf/bin"

source ~/.fzf.zsh

source "/Users/alvaro/.fzf/shell/completion.zsh" 2> /dev/null
source "/Users/alvaro/.fzf/shell/key-bindings.zsh"
bindkey "^T" fzf-cd-widget
bindkey "^F" fzf-file-widget

function  _fzf_compgen_path() {
    command fd --type f --color=never
}
function  _fzf_compgen_dir() {
    command fd --type d --color=never
}

fzf_z() {
  if [[ -z "$*" ]]; then
    cd "$(_z -l 2>&1 | sed 's/^[0-9,.]* *//' | fzf-tmux --height 40% --preview='exa {} -lh --color=always')"
  else
    _last_z_args="$@"
    _z "$@"
  fi
}

frg() {
  if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
  rg --files-with-matches --no-messages "$1" $2 | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || rg --ignore-case --pretty --context 10 '$1' {}"
}

fzf_git_add() {
    local selections=$(
      git status --porcelain | \
      fzf-tmux --ansi \
          --preview 'if (git ls-files --error-unmatch {2} &>/dev/null); then
                         git diff --color=always {2}
                     else
                         bat --color=always --line-range :500 {2}
                     fi'
      )
    if [[ -n $selections ]]; then
        git add --verbose $(echo "$selections" | cut -c 4- | tr '\n' ' ')
    fi
}

fzf_git_checkout() {
  local tags branches target
  branches=$(
    git --no-pager branch --all \
      --format="%(if)%(HEAD)%(then)%(else)%(if:equals=HEAD)%(refname:strip=3)%(then)%(else)%1B[0;34;1mbranch%09%1B[m%(refname:short)%(end)%(end)" \
    | sed '/^$/d') || return
  tags=$(
    git --no-pager tag | awk '{print "\x1b[35;1mtag\x1b[m\t" $1}') || return
  target=$(
    (echo "$branches"; echo "$tags") |
    fzf --no-hscroll --no-multi -n 2 \
        --ansi --preview="git --no-pager log -150 --pretty=format:%s '..{2}'") || return
  git checkout $(awk '{print $2}' <<<"$target" )
}

fzf_git_log() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf-tmux --ansi --no-sort --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
              FZF-EOF"
}

fzf_git_reflog() {
    local selection=$(
      git reflog --color=always "$@" |
        fzf-tmux --no-multi --ansi --no-sort --height 100% \
            --preview "git show --color=always {1}"
      )
    if [[ -n $selection ]]; then
        git show $(echo $selection | cut -d' ' -f1)
    fi
}

# $1 = count. Add any $2 to go forwards in time
function dates() {
    [ -z "$2" ] && s="-" || s="+"
    for ((i=0; i<=$1; i++)); do date -v${s}${i}d '+%F %A'; done
}


function fzf_dates() {
    dates $1 $2 | fzf-tmux --preview="bat ~/Dropbox/wiki/diary/{1}.md --theme="base16" --color=always --style=\"numbers\" 2>/dev/null"
}

# fzf-tab plugin

FZF_TAB_COMMAND=(
    fzf
    --ansi   # Enable ANSI color support, necessary for showing groups
    --expect='$continuous_trigger' # For continuous completion
    '--color=hl:$(( $#headers == 0 ? 108 : 255 ))'
    --nth=2,3 --delimiter='\x00'  # Don't search prefix
    --layout=reverse --height='${FZF_TMUX_HEIGHT:=75%}'
    --tiebreak=begin -m --bind=tab:down,change:top,ctrl-s:toggle --cycle
    '--query=$query'   # $query will be expanded to query string at runtime.
    '--header-lines=$#headers' # $#headers will be expanded to lines of headers at runtime
)

fzf-ctrl-completion() {
  local tokens cmd prefix trigger tail matches lbuf d_cmds
  setopt localoptions noshwordsplit noksh_arrays noposixbuiltins

  # http://zsh.sourceforge.net/FAQ/zshfaq03.html
  # http://zsh.sourceforge.net/Doc/Release/Expansion.html#Parameter-Expansion-Flags
  tokens=(${(z)LBUFFER})
  if [ ${#tokens} -lt 1 ]; then
    # zle ${fzf_default_completion:-expand-or-complete}
    _fzf_path_completion "$prefix" "$lbuf"
    return
  fi

  cmd=$(__fzf_extract_command "$LBUFFER")

  # Explicitly allow for empty trigger.
  trigger=''
  [ -z "$trigger" -a ${LBUFFER[-1]} = ' ' ] && tokens+=("")

  # When the trigger starts with ';', it becomes a separate token
  if [[ ${LBUFFER} = *"${tokens[-2]}${tokens[-1]}" ]]; then
    tokens[-2]="${tokens[-2]}${tokens[-1]}"
    tokens=(${tokens[0,-2]})
  fi

  tail=${LBUFFER:$(( ${#LBUFFER} - ${#trigger} ))}
  # Kill completion (do not require trigger sequence)
  if [ $cmd = kill -a ${LBUFFER[-1]} = ' ' ]; then
    matches=$(command ps -ef | sed 1d | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-50%} --min-height 15 --reverse $FZF_DEFAULT_OPTS $FZF_COMPLETION_OPTS --preview 'echo {}' --preview-window down:3:wrap" __fzf_comprun "$cmd" -m | awk '{print $2}' | tr '\n' ' ')
    if [ -n "$matches" ]; then
      LBUFFER="$LBUFFER$matches"
    fi
    zle reset-prompt
  # Trigger sequence given
  elif [ ${#tokens} -gt 1 -a "$tail" = "$trigger" ]; then
    d_cmds=(${=FZF_COMPLETION_DIR_COMMANDS:-cd pushd rmdir})

    [ -z "$trigger"      ] && prefix=${tokens[-1]} || prefix=${tokens[-1]:0:-${#trigger}}
    [ -z "${tokens[-1]}" ] && lbuf=$LBUFFER        || lbuf=${LBUFFER:0:-${#tokens[-1]}}

    if eval "type _fzf_complete_${cmd} > /dev/null"; then
      prefix="$prefix" eval _fzf_complete_${cmd} ${(q)lbuf}
    elif [ ${d_cmds[(i)$cmd]} -le ${#d_cmds} ]; then
      _fzf_dir_completion "$prefix" "$lbuf"
    else
      _fzf_path_completion "$prefix" "$lbuf"
    fi
  # Fall back to default completion
  else
    # zle ${fzf_default_completion:-expand-or-complete}
    _fzf_path_completion "$prefix" "$lbuf"
  fi
}
zle     -N   fzf-ctrl-completion
bindkey '^F' fzf-ctrl-completion

zstyle ':fzf-tab:*' command $FZF_TAB_COMMAND

