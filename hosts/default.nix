{
  nixpkgs,
  lix,
  lix-module,
  home-manager,
  nixvim,
  rpi5kernel,
  talhelper,
  zen-browser,
  ags,
  catppuccin,
  agenix,
  vars,
  ...
}: let
  mkSystem = {
    hostName,
    system,
    stateVersion ? "23.11",
    monitors ? {},
  }:
    nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit
          nixpkgs
          talhelper
          zen-browser
          ags
          catppuccin
          agenix
          vars
          hostName
          system
          stateVersion
          ;
      };
      modules = [
        ./${hostName}
        ./configuration.nix
        lix-module.nixosModules.default
        agenix.nixosModules.default

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = {
            inherit system vars stateVersion monitors zen-browser ags;
          };
          home-manager.users.${vars.user} = {
            imports = [
              (import ./home.nix)
              (import ./${hostName}/home.nix)
              nixvim.homeModules.nixvim
              ags.homeManagerModules.default
              catppuccin.homeModules.catppuccin
            ];
          };
        }
      ];
    };

  mkPi = {
    hostName,
    system,
    stateVersion ? "23.11",
    extraModules ? [],
  }:
    nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit
          nixpkgs
          rpi5kernel
          vars
          hostName
          system
          stateVersion
          ;
      };
      modules = [./${hostName}] ++ extraModules;
    };

  mkPiImage = {
    hostName,
    system,
    stateVersion ? "23.11",
  }:
    (mkPi {
      hostName = hostName;
      system = system;
      stateVersion = stateVersion;
      extraModules = [
        "${nixpkgs}/nixos/modules/installer/sd-card/sd-image-aarch64.nix"
        {disabledModules = ["profiles/base.nix"];}
      ];
    })
    .config
    .system
    .build
    .sdImage;
in {
  arc = mkSystem {
    hostName = "arc";
    system = "x86_64-linux";
    stateVersion = "23.11";
    monitors = {
      primary = {
        output = "DP-2"; # $ hyprctl monitors all
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

  pi5 = mkPi {
    hostName = "pi5";
    system = "aarch64-linux";
    stateVersion = "23.11";
  };

  pi5Image = mkPiImage {
    hostName = "pi5";
    system = "aarch64-linux";
    stateVersion = "23.11";
  };
}
