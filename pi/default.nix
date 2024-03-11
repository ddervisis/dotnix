{ inputs, nixpkgs, nixos-hardware, vars, ... }:

let
  system = "aarch64-linux";
  mkSystem = { hostName, stateVersion ? "23.11", extraModules ? [ ] }:
    nixpkgs.lib.nixosSystem rec {
      specialArgs = {
        inherit inputs nixpkgs vars hostName system stateVersion;
      };
      modules = [
        nixos-hardware.nixosModules.raspberry-pi-4
        "${nixpkgs}/nixos/modules/profiles/minimal.nix"
        ./${hostName}
        ./configuration.nix
      ] ++ extraModules;
    };

  mkImage = { hostName, stateVersion ? "23.11" }:
    (mkSystem {
      hostName = hostName;
      stateVersion = stateVersion;
      extraModules = [
        "${nixpkgs}/nixos/modules/installer/sd-card/sd-image-aarch64.nix"
        { disabledModules = [ "profiles/base.nix" ]; }
      ];
    }).config.system.build.sdImage;
in {
  pi5 = mkSystem {
    hostName = "pi5";
    stateVersion = "23.11";
  };
  pi5Image = mkImage {
    hostName = "pi5";
    stateVersion = "23.11";
  };
}
