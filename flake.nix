{
  description = "NixOS config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

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

  outputs =
    {
      nixpkgs,
      home-manager,
      darwin,
      nixvim,
      rpi5kernel,
      talhelper,
      ...
    }:
    let
      vars = {
        user = "gr4pe";
        # user = "dennis.dervisis";
        terminal = "kitty";
        editor = "nvim";
      };
      nix.registry.nixpkgs.flake = nixpkgs;
    in
    {
      nixosConfigurations = (
        import ./hosts {
          inherit (nixpkgs) lib;
          inherit
            nixpkgs
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
