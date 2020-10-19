alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# some more ls aliases
alias ls="ls -F $(ls --help 2>&1 | grep -qo -- --color && echo "--color=auto" || echo \-G)"
alias ll='ls -alhF'
alias la='ls -A'
alias l='ls -CF'
alias py='python2'
alias py3='python3'
alias up='cd ..'
alias u2='cd ../..'
alias u3='cd ../../..'
alias tmux='tmux -f ~/.config/tmux/tmux.conf'
alias gotest='go test -v -count=1 ./...'
alias gopest='go test -v -count=1 -parallel 4 ./...'
alias clear='clear ; tmux clear-history 2>/dev/null'
alias display-message='tmux display-message'

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
# SOLARIZED export LSCOLORS=GxFxCxDxBxegedabagaced

export GOPATH=~/.local/go
export CARGO_HOME=~/.local/rust/cargo
export RUSTUP_HOME=~/.local/rust/rustup

export XDG_CONFIG_HOME=~/.config
if [ -s ~/.config/nvm/nvm.sh ]
then
    # export NVM_DIR=~/.config/nvm
    # source $NVM_DIR/nvm.sh --no-use
    source ~/.config/nvm/nvm.sh --no-use
fi

function clean-path() {
    for d in ~/.local/goroot/bin ~/.local/rust/cargo/bin ~/.local/go/bin ~/.local/bin ~/.local/usr/bin
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

    # clean path, thanks https://unix.stackexchange.com/a/40755/26585
    export PATH=`printf %s "$PATH" | awk -v RS=: '{ if (!arr[$0]++) {printf("%s%s",!ln++?"":":",$0)}}'`
}

clean-path
