{
  description = "NixOS config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rpi5kernel.url = "gitlab:vriska/nix-rpi5";
  };

  outputs = inputs@{ self, nixpkgs, nixos-hardware, home-manager, darwin
    , nixvim, rpi5kernel, ... }:
    let
      vars = {
        user = "gr4pe";
        # user = "dennis.dervisis";
        terminal = "kitty";
        editor = "nvim";
      };
    in {
      nixosConfigurations = (import ./hosts {
        inherit (nixpkgs) lib;
        inherit inputs nixpkgs home-manager nixvim rpi5kernel vars;
      });

      darwinConfigurations = (import ./darwin {
        inherit (nixpkgs) lib;
        inherit inputs nixpkgs home-manager nixvim darwin vars;
      });
    };
}
