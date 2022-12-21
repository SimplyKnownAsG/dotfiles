{ config, pkgs, nixpkgs, lib, ... }:
{
  fonts.fontconfig.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.packages = with pkgs; [
    nix

    bashInteractive
    ctags
    jq
    mesa
    ncurses
    neovim
    silver-searcher
    tree

    cascadia-code

    slack

    nodejs
    nodePackages.typescript-language-server

    python3
  ]
  ++ (
    if pkgs.stdenv.hostPlatform.isDarwin
    then
      [ ]
    else
      [ pkgs.signal-desktop ]
  )
  ++ (with python3Packages; [
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

  targets.genericLinux.enable = !pkgs.stdenv.hostPlatform.isDarwin;

  programs = {
    # Let Home Manager install and manage itself.
    home-manager = {
      enable = true;
    };

    git = {
      enable = true;
      lfs.enable = true;
      ignores = [
        ".*.swp"
        "build"
        "*.pyc"
        "__pycache__/"
        "Session.vim"
        ".vim/"
        ".factorypath"
        ".project"
        ".classpath"
        ".settings/"
        "lombok.config"
        "annotation-generated-src/"
        "/?/"
      ];
      aliases = {
        co = ''checkout'';
        st = ''status'';
        hist = ''log --pretty=format:"%h %ad | %s%d [%an]" --graph --date=short'';
        sed = ''!f() { git ls-files -z | xargs -0 sed -i "$1"; }; f'';
        squash = ''!f() { git reset --hard $1 && git merge --squash HEAD@{1} && git commit ; }; f'';
        grep = ''grep -n'';
        br = ''branch'';
        cl = ''clean -fxd'';
        filetype = ''diff --stat 4b825dc642cb6eb9a060e54bf8d69288fbee4904 HEAD --'';
      };
      extraConfig = {
        core = {
          push = "nothing";
          autocrlf = "input";
        };
        pull = {
          rebase = "true";
        };
        fetch = {
          prune = "true";
        };
        diff = {
          colorMoved = "zebra";
        };
      };
      hooks = {
        pre-commit = ./dot/config/git/githooks/pre-commit;
      };
    };

    bash = {
      enable = true;
      historyControl = [ "erasedups" "ignoredups" "ignorespace" ];
      enableCompletion = true;
      initExtra = ''
        set -o vi
        PS1='\[\e[38;5;135m\]\u\[\e[0m\]@\[\e[38;5;14m\]\h\[\e[0m\]:\[\e[38;5;228m\]\w\[\e[0m\]\n\$ '
      '';
    };

    kitty = {
      enable = true;
      settings = {
        shell = pkgs.bashInteractive.outPath + pkgs.bashInteractive.shellPath + " --login";
        copy_on_select = "yes";
        macos_option_as_alt = "yes";
        macos_thicken_font = "0.1";

        # OSC52 override to be "normal"
        clipboard_control = "write-clipboard write-primary no-append";

        font_family = "Cascadia Code PL";
        font_size = "10.0";
        enabled_layouts = "splits";
        "scrollback_pager" = "less -i --chop-long-lines --RAW-CONTROL-CHARS +INPUT_LINE_NUMBER";
        "scrollback_lines" = "2000";

        # size in megabyes
        "scrollback_pager_history_size" = "50";

        "allow_remote_control" = "yes";
      };
      keybindings = {
        "ctrl+shift+equal" = "change_font_size all +1.0";
        "ctrl+shift+plus" = "change_font_size all +1.0";
        "ctrl+shift+kp_add" = "change_font_size all +1.0";

        "ctrl+shift+minus" = "change_font_size all -1.0";
        "ctrl+shift+kp_subtract" = "change_font_size all -1.0";

        "alt+shift+\\" = "launch --location=vsplit --cwd=current";
        "alt+shift+minus" = "launch --location=hsplit --cwd=current";

        "alt+left"    = "neighboring_window left";
        "alt+h"       = "neighboring_window left";
        "alt+right"   = "neighboring_window right";
        "alt+l"       = "neighboring_window right";
        "alt+up"      = "neighboring_window up";
        "alt+k"       = "neighboring_window up";
        "alt+down"    = "neighboring_window down";
        "alt+j"       = "neighboring_window down";

        "alt+shift+h" = "resize_window narrower";
        "alt+shift+l" = "resize_window wider";
        "alt+shift+k" = "resize_window taller";
        "alt+shift+j" = "resize_window shorter";
      };
    };

  };
}
