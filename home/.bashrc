# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=2000
HISTFILESIZE=5000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt | grep -q globstar && shopt -s globstar

if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    PS1='\[\e[38;5;135m\]\u\[\e[0m\]@\[\e[38;5;14m\]\h\[\e[0m\]:\[\e[38;5;228m\]\w\[\e[0m\]\n\$ '
else
    PS1='\u@\h:\w\$ '
fi

