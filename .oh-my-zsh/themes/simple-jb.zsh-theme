# oh-my-zsh Bureau Theme
### COLORS


### NVM

ZSH_THEME_NVM_PROMPT_PREFIX="%B⬡%b "
ZSH_THEME_NVM_PROMPT_SUFFIX=""

### Git [±master ▾●]
ZSH_THEME_GIT_PROMPT_PREFIX="[%{$fg_bold[green]%}% ±%{$reset_color%}%{$fg_bold[white]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}]"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$reset_color%}%{$fg_bold[green]%}✓%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_AHEAD="%{$reset_color%}%{$fg[cyan]%}▴%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_BEHIND="%{$reset_color%}%{$fg[magenta]%}▾%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_STAGED="%{$reset_color%}%{$fg_bold[green]%}●%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNSTAGED="%{$reset_color%}%{$fg_bold[yellow]%}●%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$reset_color%}%{$fg_bold[red]%}●%{$reset_color%}"

#ZSH_THEME_GIT_PROMPT_PREFIX="[%{${BOLD_GREEN}%}±%{$reset_color%}"
#ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}]"
#ZSH_THEME_GIT_PROMPT_CLEAN="%{${BOLD_GREEN}%}✓%{$reset_color%}"
#ZSH_THEME_GIT_PROMPT_AHEAD="%{${CYAN}%}▴%{$reset_color%}"
#ZSH_THEME_GIT_PROMPT_BEHIND="%{${MAGENTA}%}▾%{$reset_color%}"
#ZSH_THEME_GIT_PROMPT_STAGED="%{$fg[green]%}●%{$reset_color%}"
#ZSH_THEME_GIT_PROMPT_UNSTAGED="%{${YELLOW}%}●%{$reset_color%}"
#ZSH_THEME_GIT_PROMPT_UNTRACKED="%{${RED}%}●%{$reset_color%}"

bureau_git_branch () {
  ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
  echo "${ref#refs/heads/}"
}

bureau_git_status () {
  _INDEX=$(command git status --porcelain -b 2> /dev/null)
  _STATUS=""
  if $(echo "$_INDEX" | grep '^[AMRD]. ' &> /dev/null); then
    _STATUS="$_STATUS$ZSH_THEME_GIT_PROMPT_STAGED"
  fi
  if $(echo "$_INDEX" | grep '^.[MTD] ' &> /dev/null); then
    _STATUS="$_STATUS$ZSH_THEME_GIT_PROMPT_UNSTAGED"
  fi
  if $(echo "$_INDEX" | grep -E '^\?\? ' &> /dev/null); then
    _STATUS="$_STATUS$ZSH_THEME_GIT_PROMPT_UNTRACKED"
  fi
  if $(echo "$_INDEX" | grep '^UU ' &> /dev/null); then
    _STATUS="$_STATUS$ZSH_THEME_GIT_PROMPT_UNMERGED"
  fi
  if $(command git rev-parse --verify refs/stash >/dev/null 2>&1); then
    _STATUS="$_STATUS$ZSH_THEME_GIT_PROMPT_STASHED"
  fi
  if $(echo "$_INDEX" | grep '^## .*ahead' &> /dev/null); then
    _STATUS="$_STATUS$ZSH_THEME_GIT_PROMPT_AHEAD"
  fi
  if $(echo "$_INDEX" | grep '^## .*behind' &> /dev/null); then
    _STATUS="$_STATUS$ZSH_THEME_GIT_PROMPT_BEHIND"
  fi
  if $(echo "$_INDEX" | grep '^## .*diverged' &> /dev/null); then
    _STATUS="$_STATUS$ZSH_THEME_GIT_PROMPT_DIVERGED"
  fi

  echo $_STATUS
}

bureau_git_prompt () {
  local _branch=$(bureau_git_branch)
  local _status=$(bureau_git_status)
  local _result=""
  if [[ "${_branch}x" != "x" ]]; then
    _result="$ZSH_THEME_GIT_PROMPT_PREFIX$_branch"
    if [[ "${_status}x" != "x" ]]; then
      _result="$_result $_status"
    fi
    _result="$_result$ZSH_THEME_GIT_PROMPT_SUFFIX"
  fi
  echo $_result
}


#_PATH="%{$reset_color%}%{${WHITE}%}%c%{$reset_color%}"
_PATH="%{$fg_bold[white]%}%c%{$reset_color%}"
#if [[ $EUID -eq 0 ]]; then
#  _USERNAME="%{$fg_bold[red]%}%n"
#  _LIBERTY="%{$fg[red]%}#"
#else
#  _USERNAME="%{$fg_bold[white]%}%n"
#  _LIBERTY="%{$fg[green]%}$"
#fi
#_USERNAME="$_USERNAME%{$reset_color%}@%m"
#_LIBERTY="$_LIBERTY%{$reset_color%}"

if [[ $EUID -eq 0 ]]; then
  _USERNAME="%{$fg_bold[red]%}%n"
  _LIBERTY="%{$fg[red]%}#"
else
  _USERNAME="%{$fg[white]%}%n"
  _LIBERTY="%{$fg[green]%}$"
fi
_USERNAME="$_USERNAME%{$reset_color%}%{$fg[red]%}@%{$fg[white]%}%m:%c"





setopt prompt_subst
PROMPT='$_USERNAME%%%{$reset_color%} '
RPROMPT='$(nvm_prompt_info) %~%{$reset_color%} %{$fg_bold[white]%}[%*]%{$reset_color%}'
