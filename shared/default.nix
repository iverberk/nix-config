{ config, pkgs, user, nixpkgs-unstable, ... } :
{
  nix = {
    package = pkgs.nixVersions.latest;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowBroken = true;
      allowInsecure = false;
      allowUnsupportedSystem = true;
    };

    overlays = [
      (final: prev: {
        unstable = import nixpkgs-unstable {
          system = "${prev.system}";
          config.allowUnfree = true;
        };
      })
    ];
  };
}
