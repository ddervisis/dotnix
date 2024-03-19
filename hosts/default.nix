{ inputs, nixpkgs, home-manager, nur, nixvim, vars, ... }:

let
  mkSystem = { hostName, system, stateVersion ? "23.11", monitors ? { } }:
    nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs nixpkgs vars hostName system stateVersion;
      };
      modules = [
        #nur.nixosModules.nur
        ./${hostName}
        ./configuration.nix

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = {
            inherit nur vars stateVersion monitors;
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
  arc = mkSystem {
    hostName = "arc";
    system = "x86_64-linux";
    stateVersion = "23.11";
    monitors = {
      primary = {
        output = "DP-2"; # $ swaymsg -t get_outputs
        resolution = {
          width = "2560";
          height = "1440";
        };
      };
      secondary = {
        output = "HDMI-A-1";
        resolution = {
          width = "2560";
          height = "1440";
        };
      };
      tertiary = {
        output = "DP-3";
        resolution = {
          width = "2560";
          height = "1440";
        };
      };
    };
  };

  castle-peak = mkSystem {
    hostName = "castle-peak";
    system = "x86_64-linux";
    stateVersion = "23.11";
  };
}

