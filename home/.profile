if [ -d "$HOME/.nix-profile/bin" ]
then
    export PATH="$HOME/.nix-profile/bin:$PATH"
fi

if [ -d "$HOME/.nix-profile/share" ]
then
    if [ -z "$XDG_DATA_DIRS" ]
    then
        export XDG_DATA_DIRS="$HOME/.nix-profile/share"
    else
        export XDG_DATA_DIRS="$HOME/.nix-profile/share:$XDG_DATA_DIRS"
    fi
fi

# https://github.com/NixOS/nixpkgs/issues/64665
export LD_PRELOAD=/lib/x86_64-linux-gnu/libnss_sss.so.2

