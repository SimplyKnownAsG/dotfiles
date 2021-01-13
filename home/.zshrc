source ~/.profile

unsetopt CORRECT_ALL
setopt PROMPT_SUBST
althome=`readlink -f $HOME 2>/dev/null`
if [[ "$althome" != "" ]]
then
    function git_prompt_info() {
        git_info=$(git describe --all --dirty=-%F{196}dirty 2>/dev/null)
        if [[ ! -z "$git_info" ]]
        then
          git_info="%F{15}[%F{130}$git_info%F{15}]%f"
        fi
        curdir=`dirs | sed "s@$althome@~@g"`
        echo "%F{93}%M%f %F{15}@%f %F{45}20%DT%*%f %F{15}:%f %F{228}$curdir%f $git_info\n%F{15}\$%f "
    }
else
    function git_prompt_info() {
        git_info=$(git describe --all --dirty=-%F{196}dirty 2>/dev/null)
        if [[ ! -z "$git_info" ]]
        then
          git_info="%F{15}[%F{130}$git_info%F{15}]%f"
        fi
        curdir=`dirs`
        echo "%F{93}%M%f %F{15}@%f %F{45}20%DT%*%f %F{15}:%f %F{228}$curdir%f $git_info\n%F{15}\$%f "
    }
fi

PS1=$'$(git_prompt_info)'

alias bk='cd "${OLDPWD}"'

bindkey "^R" history-incremental-search-backward
bindkey "^E" end-of-line
bindkey "^A" beginning-of-line

setopt RM_STAR_SILENT           # do not prompt when using rm *
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
