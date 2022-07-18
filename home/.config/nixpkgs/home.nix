{ config, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;
  
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "malmgg";
  home.homeDirectory = "/home/ANT.AMAZON.COM/malmgg";
  home.packages = [
    pkgs.git
    pkgs.neovim
    pkgs.mesa
    pkgs.slack
    pkgs.ncurses
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    LSCOLORS = "GxFxCxDxBxegedabagaced";
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # get .desktop files picked up with XDG_DATA_DIRS
  targets.genericLinux.enable = true;
  programs.kitty.enable = true;
  programs.bash = {
    enable = true;
    shellAliases = {
       ls = "ls --color=auto";
       ll = "ls -alhF";
       up = "cd ..";
       u2 = "cd ../..";
    };
    profileExtra = ''
        alias kitty='nix run --impure github:guibou/nixGL -- kitty'
    '';
    initExtra = ''
        PS1='\[\e[38;5;135m\]\u\[\e[0m\]@\[\e[38;5;14m\]\h\[\e[0m\]:\[\e[38;5;228m\]\w\[\e[0m\]\n\$ '
        clear() {
            # https://github.com/kovidgoyal/kitty/issues/268#issuecomment-419342337
            printf '\033[2J\033[3J\033[1;1H'
        }
        # althome=`readlink -f $HOME 2>/dev/null`
        # if [[ "$althome" != "" ]]
        # then
        #     function git_prompt_info() {
        #         git_info=$(git describe --all --dirty=-%F{196}dirty 2>/dev/null)
        #         if [[ ! -z "$git_info" ]]
        #         then
        #           git_info="%F{15}[%F{130}$git_info%F{15}]%f"
        #         fi
        #         curdir=`dirs | sed "s@$althome@~@g"`
        #         echo "%F{93}%M%f %F{15}@%f %F{45}20%DT%D{%H:%M:%S}%f %F{15}:%f %F{228}$curdir%f $git_info\n%F{15}\$%f "
        #     }
        # else
        #     function git_prompt_info() {
        #         git_info=$(git describe --all --dirty=-%F{196}dirty 2>/dev/null)
        #         if [[ ! -z "$git_info" ]]
        #         then
        #           git_info="%F{15}[%F{130}$git_info%F{15}]%f"
        #         fi
        #         curdir=`dirs`
        #         echo "%F{93}%M%f %F{15}@%f %F{45}20%DT%D{%H:%M:%S}%f %F{15}:%f %F{228}$curdir%f $git_info\n%F{15}\$%f "
        #     }
        # fi
        # 
        # PS1=$'$(git_prompt_info)'
        
        alias bk='cd "''${OLDPWD}"'
    '';
  };

  # programs.kitty.enable = true;
}
