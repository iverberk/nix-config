{ config, pkgs, lib, ... } :
{
  ## Settings

  home = {
    enableNixpkgsReleaseCheck = false;
    username = "iverberk";
    homeDirectory = "/home/iverberk";
    packages = pkgs.callPackage ./packages.nix {};
    stateVersion = "23.05";
  };

  wayland.windowManager.sway = {
    enable = true;

    config = {
      terminal = "wezterm";
      modifier = "Mod4";

      output = {
        Virtual-1 = {
          scale = "2";
        };
      };
    };
  };

  ## Services

  services.copyq.enable = true;

  # Auto mount devices
  services.udiskie.enable = true;

  ## Programs

  programs = {

    wezterm = {
      enable = true;
      extraConfig = ''
        return {
          font_size = 16.0
        }
      '';
    };

  } // import ../shared/home-manager/programs.nix { inherit config pkgs lib; };

}