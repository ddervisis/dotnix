{ lib, inputs, nixpkgs, darwin, home-manager, nixvim, vars, ... }:

let
  system = "aarch64-darwin";
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };

  mkSystem = { hostName, system, stateVersion ? "23.11" }:
    darwin.lib.darwinSystem rec {
      inherit system;
      specialArgs = { inherit inputs pkgs system vars; };
      modules = [
        nixvim.nixDarwinModules.nixvim
        ./${hostName}
        ./configuration.nix

        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit vars stateVersion; };
          home-manager.users.${vars.user} = {
            imports = [ (import ./home.nix) ]
              ++ [ (import ./${hostName}/home.nix) ]
              ++ [ nixvim.homeManagerModules.nixvim ];
          };
        }
      ];
    };
in {
  macbook = mkSystem { # Mac15,6 (2023)
    hostName = "macbook";
    system = "aarch64-darwin";
    stateVersion = "23.11";
  };

  macmini = mkSystem { # Macmini9,1 (2020)
    hostName = "macmini";
    system = "aarch64-darwin";
    stateVersion = "23.11";
  };
}
