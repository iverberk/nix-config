{ config, pkgs, inputs, ... }:

let
  locale = "C.UTF-8";
in
{
  # Manage fonts with home-manager
  fonts.fontconfig.enable = true;

  # Enable default XDG directories
  xdg.enable = true;

  # Enable application launchers via .desktop files
  targets.genericLinux.enable = true;

  # Manage home-manager with home-manager
  programs.home-manager.enable = true;

  # Install default user packages
  home = {
    packages = with pkgs; [
      k9s
      azure-cli
      awscli2
      tree-sitter
      tree
      htop
      ripgrep
      gcc
      jq
      gopls
      sops
      age
      fnm
      kubectl
      kubernetes-helm
      stern
      kube3d
      docker-compose
      shellcheck
      shfmt
      python39
      python39Packages.pip
      python39Packages.black
      python39Packages.isort
      python39Packages.pylint
      python39Packages.setuptools
      python39Packages.debugpy
      nixgl.nixGLIntel # Needed for Kitty
      nodePackages.fixjson
      nodePackages.typescript
      nodePackages.eslint_d
      nodePackages.prettier_d_slim
      yamllint
      terraform
      unstable.argocd
      golangci-lint
      stdenv.cc.cc.lib
    ];

    sessionVariables = {
      LANG = locale;
      LC_ALL = locale;
    };
  };

  xdg.configFile."yamllint/config".source = ./home/yamllint;

  programs.vscode = {
    enable = true;

    extensions = [
      pkgs.vscode-extensions.ms-python.python
      pkgs.vscode-extensions.golang.go
    ];

    userSettings = {
      "window.titleBarStyle" = "custom"; # Get rid of the system title bar
    };
  };

  programs.git = {
    enable = true;
    userName = "Ivo Verberk";
    userEmail = "ivo@itiation.nl";
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.neovim = {
    enable = true;
  };

  xdg.configFile."nvim" = {
    source = ./nvim;
    recursive = true;
  };

  programs.kitty = {
    enable = true;
    package = pkgs.kitty;
    font.name = "Meslo";
    font.package = (pkgs.nerdfonts.override { fonts = [ "Meslo" ]; });
  };

  xdg.desktopEntries = {
    kitty = {
      name = "Kitty";
      exec = "nixGLIntel kitty --start-as=fullscreen";
      terminal = false;
      icon = "kitty";
      type = "Application";
    };
  };

  xdg.configFile."kitty" = {
    source = ./kitty;
    recursive = true;
  };

  xdg.configFile."pylintrc".text = ''
    [FORMAT]
    max-line-length = 125
  '';

  programs.starship = {
    enable = true;
    settings = {};
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    shellAliases = import ./home/aliases;
    cdpath = [ "~/code/iverberk" "~/code" ];
    history = {
      ignoreDups = true;
      save = 100000;
      size = 100000;
    };
    initExtraBeforeCompInit = ''
      bindkey '^[[A' history-substring-search-up
      bindkey '^[[B' history-substring-search-down
    '';
    initExtra = ''
      eval "$(fnm env --use-on-cd)"
    '';
    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-history-substring-search"; tags = [ defer:3 ]; }
        { name = "chriskempson/base16-shell"; tags = [ use:scripts/base16-tomorrow-night-eighties.sh defer:0 ]; }
      ];
    };
  };

  programs.lazygit = {
    enable = true;
    settings = {
      quitOnTopLevelReturn = true;
      keybinding = {
        universal = {
          nextBlock = "<c-j>";
          prevBlock = "<c-k>";
        };
        commits = {
          moveDownCommit = "j";
          moveUpCommit = "k";
        };
      };
    };
  };

  programs.go = {
    enable = true;
    goPath = "code/go";
    package = pkgs.go_1_18;
  };
}
