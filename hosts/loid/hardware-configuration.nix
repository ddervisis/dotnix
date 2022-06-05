{ config, lib, pkgs, modulesPath, ... }:

let
  storageRoot = "/storage";
  dataRoot = "/data";
in
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

  fileSystems."${storageRoot}/media" = {
    device = "storage/media";
    fsType = "zfs";
    options = [ "zfsutil" ];
  };

  fileSystems."${storageRoot}/downloads" = {
    device = "storage/downloads";
    fsType = "zfs";
    options = [ "zfsutil" ];
  };

  fileSystems."${storageRoot}/cloud" = {
    device = "storage/cloud";
    fsType = "zfs";
    options = [ "zfsutil" ];
  };

  fileSystems."${storageRoot}/games" = {
    device = "storage/games";
    fsType = "zfs";
    options = [ "zfsutil" ];
  };

  fileSystems."${storageRoot}/iso" = {
    device = "storage/iso";
    fsType = "zfs";
    options = [ "zfsutil" ];
  };

  fileSystems."${storageRoot}/backup" = {
    device = "storage/backup";
    fsType = "zfs";
    options = [ "zfsutil" ];
  };

  fileSystems."${dataRoot}/vms" = {
    device = "data/vms";
    fsType = "zfs";
    options = [ "zfsutil" ];
  };

  fileSystems."${dataRoot}/containers" = {
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
