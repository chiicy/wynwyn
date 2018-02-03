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


if [[ $USER == "root" ]]; then
  CARETCOLOR="${RED}"
  USER_STRING_COLOR="${RED}"
else
  CARETCOLOR="white"
  USER_STRING_COLOR="${BLUE}"
fi


ZSH_THEME_GIT_PROMPT_PREFIX="%{$FG[$GREEN]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"

ZSH_THEME_GIT_PROMPT_DIRTY=" %{$FG[$RED]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$FG[$GREEN]%}✔%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_ADDED="%{$FG[$GREEN]%}✚ "
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$FG[$YELLOW]%}⚑ "
ZSH_THEME_GIT_PROMPT_DELETED="%{$FG[$RED]%}✖ "
ZSH_THEME_GIT_PROMPT_RENAMED="%{$FG[$BLUE]%}▴ "
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$FG[$CYAN]%}§ "
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$FG[$WHITE]%}◒ "

ZSH_THEME_GIT_TIME_SINCE_COMMIT_SHORT="%{$FG[GREEN]%}"
ZSH_THEME_GIT_TIME_SHORT_COMMIT_MEDIUM="%{$FG[YELLO]%}"
ZSH_THEME_GIT_TIME_SINCE_COMMIT_LONG="%{$FG[RED]%}"
ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL="%{$FG[WHITE]%}"

LEFT_BRACKET="%{$terminfo[bold]$FG[$BLACK]%}[%{$reset_color%}"
RIGHT_BRACKET="%{$terminfo[bold]$FG[$BLACK]%}]%{$reset_color%}"

function _git_branch() {
    if [[ -n $(git_prompt_info) ]]; then
        echo " ${LEFT_BRACKET}%{$FG[$BLACK]%}${i_dev_git}%{$reset_color%} $(git_prompt_info)${RIGHT_BRACKET}"
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


PROMPT="${virtual_env}${NEWLINE}${OS_ICON} ${user_string}${path_string}${branch_string}${NEWLINE}\$: "
RPROMPT="$(_git_time_since_commit)"

