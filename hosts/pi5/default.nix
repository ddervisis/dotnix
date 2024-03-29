{ config, lib, pkgs, hostName, vars, rpi5kernel, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  boot = {
    loader = {
      grub = {
        device = "nodev";
        efiSupport = true;
      };
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = rpi5kernel.legacyPackages.aarch64-linux.linuxPackages_rpi5;
    # kernelPackages = (import (builtins.fetchTarball https://gitlab.com/vriska/nix-rpi5/-/archive/main.tar.gz)).legacyPackages.aarch64-linux.linuxPackages_rpi5;
  };

  networking.hostName = hostName;

  users = {
    users.${vars.user} = {
      initialPassword = vars.user;
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      packages = with pkgs; [ btop ];
    };
  };

  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";

  environment.systemPackages = with pkgs; [ vim curl git ];

  services.openssh.enable = true;

  networking.firewall.enable = false;

  nix.settings = {
    experimental-features = lib.mkDefault "nix-command flakes";
    trusted-users = [ "root" "@wheel" ];
  };

  system.stateVersion = "23.11";

}
