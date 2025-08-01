{ config, pkgs, nixpkgs, lib, nixgl, ... }:
let
  shellFunctions = builtins.readFile ./shell-functions.sh;

in
{
  fonts.fontconfig.enable = true;

  nixGL.packages = nixgl.packages;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.packages = with pkgs; [
    # silver-searcher
    bashInteractive
    cascadia-code
    open-dyslexic
    ctags
    fd
    figlet # for presenting.vim
    ion-cli
    jq
    toml-cli
    lolcat
    neovim
    ncurses
    nix
    nodePackages.typescript-language-server
    nodePackages.prettier
    nodejs
    uv
    ollama
    pyright
    (
      python3.withPackages (p: with p; [
        pip
        numpy
        matplotlib
        tabulate
        scipy
        python-lsp-server
        pylsp-rope
      ])
    )
    ripgrep
    silver-searcher
    tree
    (config.lib.nixGL.wrap wezterm)
    zsh
    xclip
    graphviz
    jdt-language-server
    plantuml
    vscode
  ];

  home.activation = {
    nodejs = lib.hm.dag.entryAfter ["writeBoundary"] ''
      ${pkgs.nodejs}/bin/npm config set prefix "$HOME/.npm-global"
    '';
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    LSCOLORS = "GxFxCxDxBxegedabagaced";
  };

  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/.npm-global/bin"
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
    py = "python";
    gotest = "go test -v -count=1 ./...";
    gopest = "go test -v -count=1 -parallel 4 ./...";
    aws-cfn-list-all = ''aws cloudformation list-stacks | jq -r ".StackSummaries[].StackName" |
                xargs -I@ -P4 sh -c "aws cloudformation get-template --stack-name @ > @.json"'';
    # https://github.com/kovidgoyal/kitty/issues/268#issuecomment-419342337
    clear = ''printf '\033[2J\033[3J\033[1;1H' '';
    clip = "xclip -sel clip";
    could-you = "uv --project ~/Documents/could-you-mcp-host run could-you";
    cy = "uv --project ~/Documents/could-you-mcp-host run cy";
  };

  home.file.".config/nix/nix.conf".source = ./dot/config/nix/nix.conf;
  home.file.".config/npm/config".source = ./dot/config/npm/config;
  home.file.".config/nvim/after/ftplugin/gitcommit.vim".source = ./dot/config/nvim/after/ftplugin/gitcommit.vim;
  home.file.".config/nvim/after/ftplugin/graphql.lua".source = ./dot/config/nvim/after/ftplugin/graphql.lua;
  home.file.".config/nvim/after/ftplugin/qf.vim".source = ./dot/config/nvim/after/ftplugin/qf.vim;
  home.file.".config/nvim/colors/gtheme.lua".source = ./dot/config/nvim/colors/gtheme.lua;
  home.file.".config/nvim/ftplugin/go.vim".source = ./dot/config/nvim/ftplugin/go.vim;
  home.file.".config/nvim/ftplugin/log.vim".source = ./dot/config/nvim/ftplugin/log.vim;
  home.file.".config/nvim/ftplugin/markdown.vim".source = ./dot/config/nvim/ftplugin/markdown.vim;
  home.file.".config/nvim/ftplugin/python.lua".source = ./dot/config/nvim/ftplugin/python.lua;
  home.file.".config/nvim/ftplugin/typescript.lua".source = ./dot/config/nvim/ftplugin/typescript.lua;
  home.file.".config/nvim/ftplugin/typescriptreact.lua".source = ./dot/config/nvim/ftplugin/typescript.lua;
  home.file.".config/nvim/init.lua".source = ./dot/config/nvim/init.lua;
  home.file.".config/wezterm/wezterm.lua".source = ./dot/config/wezterm/wezterm.lua;
  home.file.".local/bin/cloudformation-dep-graph".source = ./dot/local/bin/cloudformation-dep-graph;
  home.file.".local/bin/git-config-github".source = ./dot/local/bin/git-config-github;
  home.file.".local/bin/gkill".source = ./dot/local/bin/gkill;
  home.file.".local/bin/list-colors".source = ./dot/local/bin/list-colors;
  home.file.".local/bin/diffjson".source = ./dot/local/bin/diffjson;
  home.file.".local/bin/diff-json".source = ./dot/local/bin/diffjson;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.11";

  targets.genericLinux.enable = !pkgs.stdenv.hostPlatform.isDarwin;

  xdg = {
    enable = true;
  };

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
        ".could-you-*.json"
      ];
      aliases = {
        co = ''checkout'';
        st = ''status'';
        hist = ''log --pretty=format:"%h %ad | %s%d [%an]" --graph --date=short'';
        sed = ''!f() { git ls-files -z | xargs -0 sed -i "$1"; }; f'';
        squash = ''!f() { git reset --hard $1 && git merge --squash HEAD@{1} && git commit ; }; f'';
        grep = ''grep -n'';
        br = ''branch'';
        cl = ''clean -fxde .gitignored -e .could-you*'';
        filetype = ''diff --stat 4b825dc642cb6eb9a060e54bf8d69288fbee4904 HEAD --'';
      };
      extraConfig = {
        core = {
          push = "nothing";
          autocrlf = "input";
          commentchar = ";";
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
      '' + shellFunctions;
    };

    zsh = {
      enable = true;
      enableCompletion = true;
      initContent = ''
        setopt rmstarsilent
        bindkey -v
        set -o vi
        autoload edit-command-line; zle -N edit-command-line
        bindkey -M vicmd v edit-command-line
        bindkey '^R' history-incremental-search-backward

        up-line-or-local-history() {
            zle set-local-history 1
            zle up-line-or-history
            zle set-local-history 0
        }
        zle -N up-line-or-local-history
        down-line-or-local-history() {
            zle set-local-history 1
            zle down-line-or-history
            zle set-local-history 0
        }
        zle -N down-line-or-local-history

        bindkey '^[[A' up-line-or-local-history     # Cursor up
        bindkey '^[[B' down-line-or-local-history   # Cursor down
        bindkey '^[[1;5A' up-line-or-history        # [CTRL] + Cursor up
        bindkey '^[[1;5B' down-line-or-history      # [CTRL] + Cursor down

        althome=$(readlink -f $HOME 2>/dev/null)

        [[ "$althome" != "" ]] \
          && ps1_home_tilde_fix() { dirs | sed "s@$althome@~@g" } \
          || ps1_home_tilde_fix() { dirs }

        PS1=": "
        precmd() {
            local git_info=$(git describe --all --dirty='-\e[0;31mdirty' 2>/dev/null)
            if [[ ! -z "$git_info" ]]
            then
              git_info=" [\\e[0;33m$git_info\\e[0m]"
            fi
            curdir=$(ps1_home_tilde_fix)
            printf '\e[0;32m%s\e[0m : \e[0;35m%s\e[0m%b\n' "$(date --rfc-3339=s)" "$(ps1_home_tilde_fix)" "$git_info"
        }
      '' + shellFunctions;
    };
  };
}
