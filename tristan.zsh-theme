# tristan zsh theme

# colour scheme
BLUE='000'
GREEN='047'
BLACK='016'
RED='009'
YELLOW='190'
WHITE='015'
CYAN='087'
PINK='197'
PURPLE='097'

NEWLINE=$'\n'

# Determine the time since last commit. If branch is clean,
# use a neutral color, otherwise colors will vary according to time.
function _git_time_since_commit() {
# Only proceed if there is actually a commit.
  if git log -1 > /dev/null 2>&1; then
    # Get the last commit.
    last_commit=$(git log --pretty=format:'%at' -1 2> /dev/null)
    now=$(date +%s)
    seconds_since_last_commit=$((now-last_commit))

    # Totals
    minutes=$((seconds_since_last_commit / 60))
    hours=$((seconds_since_last_commit/3600))

    # Sub-hours and sub-minutes
    days=$((seconds_since_last_commit / 86400))
    sub_hours=$((hours % 24))
    sub_minutes=$((minutes % 60))

    if [ $hours -gt 24 ]; then
      commit_age="${days}d"
      if [ "${days}" -gt '5' ]; then
        color=$RED
      else
        color=$YELLOW
      fi
    elif [ $minutes -gt 60 ]; then
      commit_age="${sub_hours}h${sub_minutes}m"
      color=$WHITE
    else
      commit_age="${minutes}m"
      color=$BLUE
    fi

    echo "%{$FG[$color]%}$commit_age%{$reset_color%}"
  fi
}

function _git_status_indicator() {

    untracked='?'
    added='+'
    modified='!'
    renamed='>>'
    deleted='✘'
    stashed='$'
    unmerged='='
    branch_ahead='⇡'
    branch_behind='⇣'
    branch_diverged='⇕'

    git_status=""
    INDEX=$(command git status --porcelain -b 2> /dev/null)

    # untracked files
    if $(echo "$INDEX" | command grep -E '^\?\? ' &> /dev/null); then
        git_status="$untracked$git_status"
    fi

    # newly added files
    if $(echo "$INDEX" | command grep '^A[ MDAU] ' &> /dev/null); then
        git_status="$added$git_status"
    elif $(echo "$INDEX" | command grep '^UA' &> /dev/null); then
        git_status="$added$git_status"
    fi

    # modified
    if $(echo "$INDEX" | command grep '^M[ MD] ' &> /dev/null); then
        git_status="$modified$git_status"
    elif $(echo "$INDEX" | command grep '^[ MARC]M ' &> /dev/null); then
        git_status="$modified$git_status"
    fi

    # renamed
    if $(echo "$INDEX" | command grep '^R[ MD] ' &> /dev/null); then
        git_status="$renamed$git_status"
    fi

    # deleted
    if $(echo "$INDEX" | command grep '^[MARCDU ]D ' &> /dev/null); then
        git_status="$deleted$git_status"
    elif $(echo "$INDEX" | command grep '^D[ UM] ' &> /dev/null); then
        git_status="$deleted$git_status"
    fi
    
    # stashed
    if $(command git rev-parse --verify refs/stash >/dev/null 2>&1); then
        git_status="$stashed$git_status"
    fi
    
    # unmerged
    if $(echo "$INDEX" | command grep '^U[UDA] ' &> /dev/null); then
        git_status="$unmerged$git_status"
    elif $(echo "$INDEX" | command grep '^AA ' &> /dev/null); then
        git_status="$unmerged$git_status"
    elif $(echo "$INDEX" | command grep '^DD ' &> /dev/null); then
        git_status="$unmerged$git_status"
    elif $(echo "$INDEX" | command grep '^[DA]U ' &> /dev/null); then
        git_status="$unmerged$git_status"
    fi

    # check if branch is ahead
    is_ahead=false
    if $(echo "$INDEX" | command grep '^## [^ ]\+ .*ahead' &> /dev/null); then
        is_ahead=true
    fi

    # check if branch is behind
    is_behind=false
    if $(echo "$INDEX" | command grep '^## [^ ]\+ .*behind' &> /dev/null); then
        is_behind=true
    fi
    
    # check if branch has diverged
    if [[ "$is_ahead" == true && "$is_behind" == true ]]; then
        branch_status="$branch_diverged"
    else 
        [[ "$is_ahead" == true ]] && branch_status="$branch_ahead"
        [[ "$is_behind" == true ]] && branch_status="$branch_behind"
    fi
    echo " %{$FG[$RED]%}$git_status%{$reset_color%}%{$FG[$PINK]%}$branch_status%{$reset_color%}"

}


if [[ $USER == "root" ]]; then
  CARETCOLOR="${RED}"
  USER_STRING_COLOR="${RED}"
else
  CARETCOLOR="white"
  USER_STRING_COLOR="${BLUE}"
fi

ZSH_THEME_GIT_PROMPT_PREFIX="%{$FG[$GREEN]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"

ZSH_THEME_GIT_PROMPT_DIRTY="$(_git_status_indicator)"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$FG[$GREEN]%}✔%{$reset_color%}"

LEFT_BRACKET="%{$terminfo[bold]$FG[$BLACK]%}[%{$reset_color%}"
RIGHT_BRACKET="%{$terminfo[bold]$FG[$BLACK]%}]%{$reset_color%}"

function _git_branch() {
    if [[ -n $(git_prompt_info) ]]; then
        git_icon="%{$FG[$BLACK]%}${i_dev_git}%{$reset_color%}"
        echo " ${LEFT_BRACKET}${git_icon} $(git_prompt_info)${RIGHT_BRACKET}"
    else
        echo ""
    fi
}


VIRTUAL_ENV_DISABLE_PROMPT=true

function _virtual_env() {
    if [[ -n $VIRTUAL_ENV ]]; then
        echo "${NEWLINE}${LEFT_BRACKET}%{$FG[$YELLOW]%}${i_dev_python}%{$reset_color%}: ${VIRTUAL_ENV:t}${RIGHT_BRACKET}"
    else
        echo ""
    fi
}

case `uname` in
    Darwin)
        OS_ICON="%{$FG[$BLACK]%}${i_dev_apple}%{$reset_color%}"
        ;;
    Linux)
        if [[ -n "cat /proc/version | grep ubuntu" ]]; then
            OS_ICON="%{$FG[$PURPLE]%}${i_dev_ubuntu}%{$reset_color%}"
        elif [[ -n "cat /proc/version | grep rasbian" ]]; then
            OS_ICON="%{$FG[$PINK]%}${i_dev_ubuntu}%{$reset_color%}"
        else
            OS_ICON="%{$FG[$BLACK]%}${i_dev_linux}%{$reset_color%}"
        fi
        ;;
    *)
        OS_ICON=''
        ;;
esac


local user_string='%{$terminfo[bold]$FG[$USER_STRING_COLOR]%}%n@%m%{$reset_color%}'
local path_string='%{$terminfo[bold]%}:%~%{$reset_color%}'
local branch_string='$(_git_branch)%{$reset_color%}'
local virtual_env='$(_virtual_env)%{$reset_color%}'
local caret='%{$FG[$CARETCOLOR]%}\$: %{$reset_color%}'


PROMPT="${virtual_env}${NEWLINE}${OS_ICON} ${user_string}${path_string}${branch_string}${NEWLINE}${caret}"
RPROMPT="$(_git_time_since_commit)"

