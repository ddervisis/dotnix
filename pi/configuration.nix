{ pkgs, config, lib, ... }:
let
  kernelSource = {
    url = "https://gitlab.com/vriska/nix-rpi5/-/archive/main.tar.gz";
    sha256 = "12110c0sbycpr5sm0sqyb76aq214s2lyc0a5yiyjkjhrabghgdcb";
  };
in {
  sdImage.compressImage = false;

  # This causes an overlay which causes a lot of rebuilding
  # environment.noXlibs = lib.mkForce false;

  # "${nixpkgs}/nixos/modules/installer/sd-card/sd-image-aarch64.nix" creates a
  # disk with this label on first boot. Therefore, we need to keep it. It is the
  # only information from the installer image that we need to keep persistent
  fileSystems."/" = {
    device = "/dev/disk/by-label/NIXOS_SD";
    fsType = "ext4";
  };
  boot = {
    kernelPackages = lib.mkForce pkgs.linuxPackages_latest;
    # kernelPackages = (import (builtins.fetchTarball
    #   kernelSource)).legacyPackages.aarch64-linux.linuxPackages_rpi5;
    loader = {
      generic-extlinux-compatible.enable = lib.mkDefault true;
      grub.enable = lib.mkDefault false;
    };
  };
  nix.settings = {
    experimental-features = lib.mkDefault "nix-command flakes";
    trusted-users = [ "root" "@wheel" ];
  };
  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
}
