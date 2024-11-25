{
  description = "Configuration for NixOS and MacOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";

    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew = {
      url = "github:zhaofengli-wip/nix-homebrew";
    };

    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };

    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, darwin, nix-homebrew, homebrew-core, homebrew-cask, home-manager, nixpkgs, nixpkgs-unstable, disko } @inputs:
    let
      user = "iverberk";

      linuxSystems = [ "x86_64-linux" "aarch64-linux" ];
      darwinSystems = [ "aarch64-darwin" ];
    in
    {

      # Define a development shell for working on the flake
      devShells = nixpkgs.lib.genAttrs (linuxSystems ++ darwinSystems) (system: 
      let 
        pkgs = nixpkgs.legacyPackages.${system}; 
      in 
      {
        default = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [ bashInteractive git ];
          shellHook = ''
            export EDITOR=vim
          '';
        };
      });

      # Define apps to install a NixOS system
      apps = nixpkgs.lib.genAttrs linuxSystems (system: 
      let
        scriptName = "install";
      in
      {
        "${scriptName}" = {
          type = "app";
          program = "${(nixpkgs.legacyPackages.${system}.writeScriptBin "${scriptName}" ''
            #!/usr/bin/env bash
            PATH=${nixpkgs.legacyPackages.${system}.git}/bin:$PATH
            echo "Running ${scriptName} for ${system}"
            exec ${self}/apps/${scriptName}
          '')}/bin/${scriptName}";
        };
      });

      # MacBook configuration
      darwinConfigurations = {
        macos = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          specialArgs = inputs // { inherit user nixpkgs-unstable; };
          modules = [
            nix-homebrew.darwinModules.nix-homebrew
            home-manager.darwinModules.home-manager
            {
              nix-homebrew = {
                enable = true;
                user = "${user}";
                taps = {
                  "homebrew/homebrew-core" = homebrew-core;
                  "homebrew/homebrew-cask" = homebrew-cask;
                };
                mutableTaps = false;
                autoMigrate = true;
              };
            }
            ./darwin
          ];
        };
      };

      # NixOS configuration
      nixosConfigurations = nixpkgs.lib.genAttrs linuxSystems (system: nixpkgs.lib.nixosSystem {
        system = system;
        specialArgs = inputs;
        modules = [
          disko.nixosModules.disko
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${user} = import ./nixos/home.nix;
          }
          ./nixos
        ];
     });
  };
}
