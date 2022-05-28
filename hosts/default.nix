{ lib, inputs, nixpkgs, home-manager, ... }:

let
  user = "gr4pe";

  mkSystem = { hostName, system, stateVersion ? "22.05" }: nixpkgs.lib.nixosSystem rec {
    specialArgs = { inherit inputs nixpkgs user hostName system stateVersion; };
    modules = [
      ./${hostName}
      ./configuration.nix

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit user stateVersion; };
        home-manager.users.${user} = {
          imports = [(import ./home.nix)] ++ [(import ./${hostName}/home.nix )];
        };
      }
    ];
  };
in
{

  arc = mkSystem {
    hostName = "arc";
    system = "x86_64-linux";
  };
  loid = mkSystem {
    hostName = "loid";
    system = "x86_64-linux";
  };

  # arc = nixpkgs.lib.nixosSystem {
  #   inherit system;
  #   specialArgs = { inherit inputs user location; };
  #   modules = [
  #     ./arc
  #     ./configuration.nix

  #     home-manager.nixosModules.home-manager {
  #       home-manager.useGlobalPkgs = true;
  #       home-manager.useUserPackages = true;
  #       home-manager.extraSpecialArgs = { inherit user; };
  #       home-manager.users.${user} = {
  #         imports = [(import ./home.nix)] ++ [(import ./arc/home.nix)];
  #       };
  #     }
  #   ];
  # };

  # loid = nixpkgs.lib.nixosSystem {
  #   inherit system;
  #   specialArgs = { inherit inputs user location; };
  #   modules = [
  #     ./loid
  #     ./configuration.nix

  #     home-manager.nixosModules.home-manager {
  #       home-manager.useGlobalPkgs = true;
  #       home-manager.useUserPackages = true;
  #       home-manager.extraSpecialArgs = { inherit user; };
  #       home-manager.users.${user} = {
  #         imports = [(import ./home.nix)] ++ [(import ./loid/home.nix)];
  #       };
  #     }
  #   ];
  # };

}
