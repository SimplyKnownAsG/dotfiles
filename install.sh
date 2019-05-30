#!/usr/bin/env bash

if [ -f $HOME/.bashrc ]
then
    echo "Removing .bashrc use .dotfiles/<profile>/home/.config/bash/init.bash"
    rm $HOME/.bashrc
fi


need_new_bashrc=true
function add_bash_source() {
    local target_path=$1
    if [[ $target_path == *init.bash ]] || [[ $target_path == *.bashrc ]] || [[ $target_path == *.bash_profile ]]
    then
        # if $need_new_bashrc ; then ; echo "# automatically generated" > $HOME/.bashrc ; fi
        if [ $need_new_bashrc = "true" ]
        then
            # rm in case it is a link
            rm $HOME/.bash_profile
            echo "# automatically generated" > $HOME/.bash_profile
        fi
        need_new_bashrc=false
        echo "source $target_path" >> $HOME/.bash_profile

        # return codes are backwards... 1 is failure 0 is success
        return 0
    else
        return 1
    fi
}


need_new_vimrc=true
function add_vim_source() {
    local target_path=$1
    if [[ $target_path == */init.vim ]] || [[ $target_path == *.vimrc ]]
    then
        if [ $need_new_vimrc = "true" ]
        then
            # rm in case it is a link
            rm $HOME/.config/nvim/init.vim
            echo '" automatically generated' > $HOME/.config/nvim/init.vim
        fi
        need_new_vimrc=false
        echo "source $target_path" >> $HOME/.config/nvim/init.vim

        # return codes are backwards... 1 is failure 0 is success
        return 0
    else
        return 1
    fi
}


homeroots=`find $HOME/.dotfiles -name home -type d`
homedirs=()
for homeroot in $homeroots
do
    echo "$homeroot"

    for dirname in $(find $homeroot -type d | sed "s@$homeroot@$HOME@g")
    do
        if [ -f $dirname ]
        then
            echo "ERROR: File exists where directory is needed: $dirname"
            exit 1
        elif [ ! -d $dirname ]
        then
            mkdir $dirname
        fi
    done

    for source_path in $(find $homeroot -type f)
    do
        target_path=$(echo $source_path | sed s@$homeroot@$HOME@g)
        if add_bash_source $source_path
        then
            echo "    bash sourcing $target_path"
        elif add_vim_source $source_path
        then
            echo "    vim sourcing $target_path"
        else
            echo "    creating link $target_path -> $source_path"
            ln -sf $source_path $target_path
        fi
    done
done
