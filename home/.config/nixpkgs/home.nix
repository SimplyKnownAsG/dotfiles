{ config, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "malmgg";
  home.homeDirectory = "/home/ANT.AMAZON.COM/malmgg";
  home.packages = with pkgs; [
    git
    neovim
    mesa
    kitty
    ncurses
    cascadia-code
    silver-searcher
    tree
    ctags

    slack
    signal-desktop

    nodejs
    nodePackages.typescript-language-server

    python3
  ] ++ (with python3Packages; [
    numpy
    pip
  ]);

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

  fonts.fontconfig.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # get .desktop files picked up with XDG_DATA_DIRS
  targets.genericLinux.enable = true;
  programs.bash = {
    enable = true;
    shellAliases = {
       ls = "ls --color=auto";
       ll = "ls -alhF";
       up = "cd ..";
       u2 = "cd ../..";
    };
    profileExtra = ''
        export PATH=$HOME/.local/bin:$PATH
    '';
    initExtra = ''
        . "$HOME/.config/shell/rc"
    '';
  };
}
