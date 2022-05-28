{ nixpkgs, config, pkgs, lib, user, hostName, system, ... }:

let
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };
in
{
  imports =
    [(import ./hardware-configuration.nix)] ++
    (import ../../modules/virtualisation) ++
    (import ../../modules/services);

  boot = {
    kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
    supportedFilesystems = [ "zfs" ];
    zfs.devNodes = "/dev/disk/by-path";

    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 5;
      };
      efi.canTouchEfiVariables = true;
      timeout = 3;
    };
  };

  networking = {
    useDHCP = false; # deprecated
    hostName = hostName;
    hostId = "bd33f6e1";
    interfaces.enp4s0.useDHCP = true;
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 ];
    };
  };

  environment = {
    systemPackages = with pkgs; [
      curl
      htop
      wget
    ];
  };

  security.sudo.wheelNeedsPassword = false;
}
