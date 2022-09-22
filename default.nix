{ config, pkgs, nixpkgs, lib, ... }:
{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
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

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  home.shellAliases = {
    ls = "ls --color=auto";
    ll = "ls -alhF";
    up = "cd ..";
    u2 = "cd ../..";
    u3 = "cd ../../..";
    grep = "grep --color=auto";
    ":q" = "exit";
    bk = ''cd ''${OLDPWD}'';
    py = "python2";
    py3 = "python3";
    gotest = "go test -v -count=1 ./...";
    gopest = "go test -v -count=1 -parallel 4 ./...";
    aws-cfn-list-all = ''aws cloudformation list-stacks | jq -r ".StackSummaries[].StackName" |
                xargs -I@ -P4 sh -c "aws cloudformation list-stack-resources --stack-name @ > @.list"'';
    # https://github.com/kovidgoyal/kitty/issues/268#issuecomment-419342337
    clear = ''printf '\033[2J\033[3J\033[1;1H' '';
  };

  home.file.".config/git/config".source = ./dot/config/git/config;
  home.file.".config/git/githooks/pre-commit".source = ./dot/config/git/githooks/pre-commit;
  home.file.".config/git/ignore".source = ./dot/config/git/ignore;
  home.file.".config/kitty/kitty.conf".source = ./dot/config/kitty/kitty.conf;
  home.file.".config/nix/nix.conf".source = ./dot/config/nix/nix.conf;
  home.file.".config/npm/config".source = ./dot/config/npm/config;
  home.file.".config/nvim/after/ftplugin/gitcommit.vim".source = ./dot/config/nvim/after/ftplugin/gitcommit.vim;
  home.file.".config/nvim/after/ftplugin/graphql.vim".source = ./dot/config/nvim/after/ftplugin/graphql.vim;
  home.file.".config/nvim/after/ftplugin/qf.vim".source = ./dot/config/nvim/after/ftplugin/qf.vim;
  home.file.".config/nvim/colors/happy.vim".source = ./dot/config/nvim/colors/happy.vim;
  home.file.".config/nvim/colors/script.py".source = ./dot/config/nvim/colors/script.py;
  home.file.".config/nvim/ftplugin/go.vim".source = ./dot/config/nvim/ftplugin/go.vim;
  home.file.".config/nvim/ftplugin/markdown.vim".source = ./dot/config/nvim/ftplugin/markdown.vim;
  home.file.".config/nvim/ftplugin/typescript.lua".source = ./dot/config/nvim/ftplugin/typescript.lua;
  home.file.".config/nvim/init.lua".source = ./dot/config/nvim/init.lua;
  home.file.".config/tmux/tmux.conf".source = ./dot/config/tmux/tmux.conf;
  home.file.".local/bin/cloudformation-dep-graph".source = ./dot/local/bin/cloudformation-dep-graph;
  home.file.".local/bin/git-config-github".source = ./dot/local/bin/git-config-github;
  home.file.".local/bin/gkill".source = ./dot/local/bin/gkill;
  home.file.".local/bin/list-colors".source = ./dot/local/bin/list-colors;
  home.file.".local/bin/update-stuff".source = ./dot/local/bin/update-stuff;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";

  fonts.fontconfig.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # get .desktop files picked up with XDG_DATA_DIRS
  targets.genericLinux.enable = true;

  programs.bash = {
    enable = true;
    initExtra = ''
      set -o vi
      PS1='\[\e[38;5;135m\]\u\[\e[0m\]@\[\e[38;5;14m\]\h\[\e[0m\]:\[\e[38;5;228m\]\w\[\e[0m\]\n\$ '
    '';
  };
}
