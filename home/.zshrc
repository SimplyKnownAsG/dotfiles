unsetopt CORRECT_ALL
setopt PROMPT_SUBST

function git_prompt_info() {
  ref=$(git describe --all --dirty=%f-%F{196}dirty 2>/dev/null) || return
  echo "[%F{130}$ref%f]"
}

PS1=$'%F{135}%n%f @ %F{14}%m%f : %F{228}%~%f $(git_prompt_info)\n$ '

alias bk='cd $OLDPWD'
