{ config, pkgs, inputs, ... }:

let
  locale = "C.UTF-8";
  homedir = builtins.getEnv "HOME";
  username = builtins.getEnv "USER";
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
      tree-sitter
      htop
      ripgrep
      gcc
      go
      gopls
      python39Full
      python39Packages.pip
      python39Packages.python-lsp-server
      nixgl.nixGLIntel # Needed for Kitty
      fishPlugins.foreign-env
      fishPlugins.pure
    ];

    sessionVariables = {
      LANG = locale;
      LC_ALL = locale;
    };
  };

  programs.vscode = {
    enable = true;
    userSettings = {
      "window.titleBarStyle" = "custom"; # Get rid of the system title bar
    };
  };

  programs.git = {
    enable = true;
    userName = "Ivo Verberk";
    userEmail = "ivo@itiation.nl";
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
  };

  xdg.configFile."nvim" = {
    source = ./nvim;
    recursive = true;
  };

  programs.kitty = {
    enable = true;
    font.name = "Meslo";
    font.package = (pkgs.nerdfonts.override { fonts = [ "Meslo" ]; });
  };

  xdg.desktopEntries = {
    kitty = {
      name = "Kitty";
      exec = "nixGLIntel kitty --start-as=maximized";
      terminal = false;
      icon = "kitty";
      type = "Application";
    };
  };

  xdg.configFile."kitty" = {
    source = ./kitty;
    recursive = true;
  };

  xdg.configFile."pycodestyle".text = ''
    [pycodestyle]
    max-line-length = 120
  '';

  programs.fish = {
    enable = true;
    plugins = [{
      name = "base16-fish";
      src = inputs.base16-fish;
    }];
    shellInit = ''
      base16-tomorrow-night-eighties
    '';
    shellAliases = import ./home/aliases;
  };

  programs.lazygit = {
    enable = true;
  };

  programs.go = {
    enable = true;
    goPath = "/home/iverberk/code/go";
  }; 
}
