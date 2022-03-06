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

  # xdg.configFile."i3/config".text = builtins.readFile ./i3;
  # xdg.configFile."rofi/config.rasi".text = builtins.readFile ./rofi;

  xsession.pointerCursor = {
    name = "Vanilla-DMZ";
    package = pkgs.vanilla-dmz;
    size = 32;
  };

  # Enable application launchers via .desktop files
  targets.genericLinux.enable = true;
  
  # Manage home-manager with home-manager
  programs.home-manager.enable = true;

  # Install default user packages
  home = {
    packages = with pkgs; [
      firefox
      tree-sitter
      htop
      ripgrep
      rofi
      i3status
      i3lock
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

  programs.i3status = {
    enable = true;

    general = {
      colors = true;
      color_good = "#8C9440";
      color_bad = "#A54242";
      color_degraded = "#DE935F";
    };

    modules = {
      ipv6.enable = false;
      "wireless _first_".enable = false;
      "battery all".enable = false;
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

      # Kitty Shell Integration
      if set -q KITTY_INSTALLATION_DIR
        set --global KITTY_SHELL_INTEGRATION enabled
        source "$KITTY_INSTALLATION_DIR/shell-integration/fish/vendor_conf.d/kitty-shell-integration.fish"
        set --prepend fish_complete_path "$KITTY_INSTALLATION_DIR/shell-integration/fish/vendor_completions.d"
      end

      # Do not show any greeting
      set --universal --erase fish_greeting
      function fish_greeting; end
      funcsave fish_greeting
    '';
    shellAliases = import ./aliases;
  };

  programs.lazygit = {
    enable = true;
  };

  programs.go = {
    enable = true;
    goPath = "/home/iverberk/code/go";
  }; 
}
