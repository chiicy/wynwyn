# tristan zsh theme

# colour scheme
local this_blue='000'
local this_green='047'
local this_black='016'
local this_red='009'
local this_yellow='190'
local this_white='015'
local this_cyan='087'


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
    elif [ $minutes -gt 60 ]; then
      commit_age="${sub_hours}h${sub_minutes}m"
    else
      commit_age="${minutes}m"
    fi

    color=$ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL
    echo "$color$commit_age%{$reset_color%}"
  fi
}


if [[ $USER == "root" ]]; then
  CARETCOLOR="red"
else
  CARETCOLOR="white"
fi


ZSH_THEME_GIT_PROMPT_PREFIX="%{$FG[$this_green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"

ZSH_THEME_GIT_PROMPT_DIRTY=" %{$FG[$this_red]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$FG[$this_green]%}✔%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_ADDED="%{$FG[$this_green]%}✚ "
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$FG[$this_yellow]%}⚑ "
ZSH_THEME_GIT_PROMPT_DELETED="%{$FG[$this_red]%}✖ "
ZSH_THEME_GIT_PROMPT_RENAMED="%{$FG[$this_blue]%}▴ "
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$FG[$this_cyan]%}§ "
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$FG[$this_white]%}◒ "


function _git_branch() {
    if [[ -n $(git_prompt_info) ]]; then
        echo " [$(git_prompt_info)]"
    else
        echo ""
    fi
}


local user_string='%{$terminfo[bold]$FG[$this_blue]%}%n@%m%{$reset_color%}'
local path_string='%{$terminfo[bold]%}:%~%{$reset_color%}'
local branch_string='$(_git_branch)%{$reset_color%}'

PROMPT="${user_string}${path_string}${branch_string}$: "

