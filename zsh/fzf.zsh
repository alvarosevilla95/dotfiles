export FZF_TMUX=1
export FZF_DEFAULT_COMMAND='fd --type f --color=never'
export FZF_DEFAULT_OPTS='--reverse --height 100%'
export FZF_ALT_C_COMMAND='fd --type d . --color=never'
export FZF_ALT_C_OPTS='--preview="exa {} -l --color=always"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS='--preview="bat {} --theme="base16" --color=always --style=\"numbers\""'
export FZF_COMPLETION_OPTS='--preview="bat {} --theme="base16" --style=\"numbers\" --color=always 2>/dev/null || exa {} -l --color=always"'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
if [[ ! "$PATH" == */home/alvaro/.fzf/bin* ]]; then
  export PATH="$PATH:/home/alvaro/.fzf/bin"
fi
[[ $- == *i* ]] && source "/Users/alvaro/.fzf/shell/completion.zsh" 2> /dev/null
source "/Users/alvaro/.fzf/shell/key-bindings.zsh"
bindkey "^T" fzf-cd-widget
bindkey "^F" fzf-file-widget

function  _fzf_compgen_path() {
    command fd --type f --color=never
}
function  _fzf_compgen_dir() {
    command fd --type d . --color=never
}
# using ripgrep combined with preview
# find-in-file - usage: fif <searchTerm>
ff() {
    if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
    local match=$(
        rg --files-with-matches --no-messages --line-number "$1" . | 
            fzf --preview "highlight -O ansi -l {} 2> /dev/null | 
                        rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || 
                            rg --ignore-case --pretty --context 10 '$1' {}"
    )
    local file=$(echo "$match" | cut -d':' -f1)
    if [[ -n $file ]]; then
        $EDITOR "$file" +$(echo "$match" | cut -d':' -f2)
    fi
}

j() {
  if [[ -z "$*" ]]; then
    cd "$(_z -l 2>&1 | sed 's/^[0-9,.]* *//' | fzf-tmux --height 40% --reverse --preview='exa {} -lh --color=always')"
  else
    _last_z_args="$@"
    _z "$@"
  fi
}

# fkill - kill process
fk() {
  local pid
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    echo $pid | xargs kill -${1:-9}
  fi
}

fb() {
  local branches branch
  branches=$(git --no-pager branch -vv) &&
  branch=$(echo "$branches" | fzf +m --height 40% --reverse) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
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

fzf_git_log() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
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

export FZF_DEFAULT_OPTS="
  --color=bg+:$color01,bg:$color00,spinner:$color0C,hl:$color0D
  --color=fg:$color04,header:$color0D,info:$color0A,pointer:$color0C
  --color=marker:$color0C,fg+:$color06,prompt:$color0A,hl+:$color0D
"
