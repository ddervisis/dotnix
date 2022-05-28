{
  description = "NixOS config";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixos-22.05;
    nixpkgs-unstable.url = github:nixos/nixpkgs/nixpkgs-unstable;

    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations = (
      import ./hosts {
        inherit (nixpkgs) lib;
        inherit inputs nixpkgs home-manager;
      }
    );
  };
}
