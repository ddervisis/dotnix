{ lib, inputs, nixpkgs, darwin, home-manager, nur, nixvim, vars, ... }:

let
  mkSystem = { hostName, system, stateVersion ? "23.11" }:
    darwin.lib.darwinSystem rec {
    inherit system;
    specialArgs = { inherit inputs vars; };
    modules = [
      ./${hostName}
      ./configuration.nix

      home-manager.darwinModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {
          inherit nur vars stateVersion;
        };
        home-manager.users.${vars.user} = {
          imports = [ (import ./home.nix) ]
            ++ [ (import ./${hostName}/home.nix) ]
            ++ [ nixvim.homeManagerModules.nixvim ];
        };
      }
    ];
  };
in {
  mbp2018 = mkSystem { # MacBookPro15,1 (2018)
    hostName = "mbp2018";
    system = "x86_64-darwin";
    stateVersion = "23.11";
  };
}
