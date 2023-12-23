{ lib, inputs, nixpkgs, darwin, home-manager, vars, ... }:

let system = "x86_64-darwin";
in {
  macbook = darwin.lib.darwinSystem {
    inherit system;
    specialArgs = { inherit inputs vars; };
    modules = [
      #./macbook.nix

      home-manager.darwinModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
      }
    ];
  };
}
