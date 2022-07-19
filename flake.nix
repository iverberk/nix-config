{
  description = "System and home configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-22.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixgl.url = "github:guibou/nixGL";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }@inputs:
  let
    system = "x86_64-linux";
    username = "iverberk";
  in {

    homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {
        inherit system;

        config = {
          allowUnfree = true;
        };
      };

      modules = [
        ./home.nix
        ({
          nixpkgs.overlays = [
            inputs.nixgl.overlay
            (final: prev: {
              unstable = nixpkgs-unstable.legacyPackages.${prev.system};
            })
          ];

          home = {
            inherit username;

            homeDirectory = "/home/${username}";
            stateVersion = "22.11";
          };
        })
      ];
    };
  };
}
