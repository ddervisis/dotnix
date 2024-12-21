{
  description = "NixOS config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    lix = {
      url = "https://git.lix.systems/lix-project/lix/archive/main.tar.gz";
      flake = false;
    };

    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/main.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.lix.follows = "lix";
    };

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

    rpi5kernel = {
      url = "gitlab:vriska/nix-rpi5";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    talhelper.url = "github:budimanjojo/talhelper";
  };

  outputs = {
    nixpkgs,
    lix,
    lix-module,
    home-manager,
    darwin,
    nixvim,
    rpi5kernel,
    talhelper,
    ...
  }: let
    vars = {
      user = "gr4pe";
      # user = "dennis.dervisis";
      terminal = "kitty";
      editor = "nvim";
    };
    nix.registry.nixpkgs.flake = nixpkgs;
  in {
    nixosConfigurations = (
      import ./hosts {
        inherit (nixpkgs) lib;
        inherit
          nixpkgs
          lix
          lix-module
          home-manager
          nixvim
          rpi5kernel
          talhelper
          vars
          ;
      }
    );

    darwinConfigurations = (
      import ./darwin {
        inherit (nixpkgs) lib;
        inherit
          nixpkgs
          home-manager
          nixvim
          darwin
          vars
          ;
      }
    );
  };
}
