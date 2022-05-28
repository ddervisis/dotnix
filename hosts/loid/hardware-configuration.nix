{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot = {
    initrd.availableKernelModules = [ "sd_mod" "sr_mod" ];
    initrd.kernelModules = [ ];
    kernelModules = [ ];
    extraModulePackages = [ ];
  };

  fileSystems."/" = {
    device = "rpool/nixos";
    fsType = "zfs";
  };

  fileSystems."/nix" = {
    device = "rpool/nixos/nix";
    fsType = "zfs";
    options = [ "zfsutil" ];
  };

  fileSystems."/media" = {
    device = "storage/media";
    fsType = "zfs";
    options = [ "zfsutil" ];
  };

  fileSystems."/downloads" = {
    device = "storage/downloads";
    fsType = "zfs";
    options = [ "zfsutil" ];
  };

  fileSystems."/cloud" = {
    device = "storage/cloud";
    fsType = "zfs";
    options = [ "zfsutil" ];
  };

  fileSystems."/games" = {
    device = "storage/games";
    fsType = "zfs";
    options = [ "zfsutil" ];
  };

  fileSystems."/iso" = {
    device = "storage/iso";
    fsType = "zfs";
    options = [ "zfsutil" ];
  };

  fileSystems."/backup" = {
    device = "storage/backup";
    fsType = "zfs";
    options = [ "zfsutil" ];
  };

  fileSystems."/vms" = {
    device = "data/vms";
    fsType = "zfs";
    options = [ "zfsutil" ];
  };

  fileSystems."/containers" = {
    device = "data/containers";
    fsType = "zfs";
    options = [ "zfsutil" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/boot";
    fsType = "vfat";
  };

  swapDevices = [
    { device = "/dev/disk/by-label/swap"; }
  ];

  hardware = {
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    video.hidpi.enable = lib.mkDefault true; # high-resolution display
    enableAllFirmware = true;
  };
}
