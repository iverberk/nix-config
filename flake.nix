{
  description = "System and home configuration";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:nixos/nixpkgs/release-21.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    base16-fish = {
      url = github:tomyun/base16-fish;
      flake = false;
    };
    nixgl.url = "github:guibou/nixGL";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
  let
    system = "x86_64-linux";
    username = "iverberk";
    overlays = [
      inputs.neovim-nightly-overlay.overlay
      inputs.nixgl.overlay
      (final: prev: {
        # To get Kitty 0.24.x. Delete this once it hits release.
        kitty = inputs.nixpkgs-unstable.legacyPackages.${prev.system}.kitty;
      })
    ];
  in {

    # NixOS configuration
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;

      modules = [
        ./nixos/hardware.nix
        ./nixos/configuration.nix
      ];
    };

    # (Non-)NixOS Home configuration
    homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
      inherit system username;

      stateVersion = "22.05";

      pkgs = import nixpkgs {
        inherit system overlays;

        config = {
          allowUnfree = true;
        };
      }; 

      homeDirectory = "/home/${username}";

      # Specify the path to your home configuration here
      configuration = import ./home/${username};

      extraSpecialArgs = { inherit inputs; };
    };
  };
}
