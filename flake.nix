{
  description = "NixOS config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-23.11";
    home-manager.url = "github:nix-community/home-manager/release-23.11";

    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur.url = "github:nix-community/NUR";

    nixvim.url = "github:nix-community/nixvim";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, darwin, nur, nixvim, ... }:
    let
      vars = {
        user = "dennis.dervisis";
        terminal = "kitty";
      };
    in {
      nixosConfigurations = (import ./hosts {
        inherit (nixpkgs) lib;
        inherit inputs nixpkgs home-manager nur nixvim vars;
      });

      darwinConfigurations = (import ./darwin {
        inherit (nixpkgs) lib;
        inherit inputs nixpkgs home-manager darwin nur nixvim vars;
      });

      homeConfigurations = (
        import ./nix {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs home-manager nur nixvim vars;
        }
      );
    };
}
