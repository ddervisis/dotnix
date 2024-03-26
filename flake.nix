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

    nur = { url = "github:nix-community/NUR"; };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rpi5kernel = {
      url = "gitlab:vriska/nix-rpi5";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, nixos-hardware, home-manager
    , darwin, nur, nixvim, rpi5kernel, ... }:
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
        inherit inputs nixpkgs home-manager nur nixvim vars;
      });

      darwinConfigurations = (import ./darwin {
        inherit (nixpkgs) lib;
        inherit inputs nixpkgs home-manager nixvim darwin vars;
      });

      piConfigurations = (import ./pi {
        inherit (nixpkgs) lib;
        inherit inputs nixpkgs nixos-hardware rpi5kernel vars;
      });
    };
}
