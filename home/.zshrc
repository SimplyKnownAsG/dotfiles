source ~/.profile

unsetopt CORRECT_ALL
setopt PROMPT_SUBST

function git_prompt_info() {
  ref=$(git describe --all --dirty=%f-%F{196}dirty 2>/dev/null) || return
  echo "[%F{130}$ref%f]"
}

PS1=$'%F{135}%n%f @ %F{14}%m%f : %F{228}%~%f $(git_prompt_info)\n$ '

alias bk='cd "${OLDPWD}"'

bindkey "^R" history-incremental-search-backward
bindkey "^E" end-of-line
bindkey "^A" beginning-of-line

setopt EXTENDED_HISTORY         # store time in history
setopt HIST_EXPIRE_DUPS_FIRST   # try to keep unique events
setopt HIST_IGNORE_DUPS         # ignore immediate duplicates
setopt HIST_VERIFY              # Make those history commands nice
setopt INC_APPEND_HISTORY       # immediatly insert history into history file
HISTSIZE=6000                   # a bit larger than SAVEHIST, per `man zshoptions`
SAVEHIST=5000

# force creatiion, ignore error
mkdir -p ~/.config/zsh || true
HISTFILE=~/.config/zsh/history

clean-path
