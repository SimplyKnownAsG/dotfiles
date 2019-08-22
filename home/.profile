alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# some more ls aliases
alias ls="ls -F $(ls --help 2>&1 | grep -qo -- --color && echo "--color=auto" || echo \-G)"
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias py='python2'
alias py3='python3'
alias up='cd ..'
alias u2='cd ../..'
alias tmux='tmux -f ~/.config/tmux/tmux.conf'

# editor stuff
if hash nvim 2>/dev/null ; then
    export EDITOR=nvim
else
    export EDITOR=vim
fi
export MYVIMRC=~/.config/nvim/init.vim
export MYGVIMRC=~/.config/nvim/ginit.vim
alias vim='vim -u $MYVIMRC'
alias gvim='vim -U $MYGVIMRC'
export LSCOLORS=GxFxCxDxBxegedabagaced

export GOPATH=~/.local/go

for d in $HOME/.local/go/bin $HOME/.local/bin $HOME/.local/usr/bin
do
    if [ -d $d ]; then
        export PATH=$d:$PATH
    fi
done

if [ -d ~/.gem/ruby/ ] ; then
    export PATH=$PATH:~/.gem/ruby/`ls -1 ~/.gem/ruby/ | sort -V | tail -n 1`/bin
fi

if hash brew 2>/dev/null
then
    export PATH=$(brew --prefix llvm)/bin:$PATH
fi

function clean-path() {
    # clean path, thanks https://unix.stackexchange.com/a/40755/26585
    export PATH=`printf %s "$PATH" | awk -v RS=: '{ if (!arr[$0]++) {printf("%s%s",!ln++?"":":",$0)}}'`
}

clean-path
