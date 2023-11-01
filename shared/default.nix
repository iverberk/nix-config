{ config, pkgs, user, ... } :
{
  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';

    settings = {
      substituters = [
        "https://nix-community.cachix.org"
        "https://cache.nixos.org/"
        "https://iverberk.cachix.org"
      ];
      trusted-public-keys = [
        "iverberk.cachix.org-1:+bgeQQuz1rCXunXOvXSQkeLTGAJYixZPwrU+8r95DvM="
      ];
    };
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowBroken = true;
      allowInsecure = false;
      allowUnsupportedSystem = true;
    };

    overlays = [];
  };
}