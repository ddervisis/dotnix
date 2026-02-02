{
  config,
  lib,
  modulesPath,
  ...
}: {
  imports = [(modulesPath + "/installer/scan/not-detected.nix")];

  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "usbhid"
    "usb_storage"
    "sd_mod"
  ];
  boot.initrd.kernelModules = ["nvidia"];
  boot.kernelModules = [
    "kvm-amd"
    "i2c-dev"
    "i2c-piix4"
  ];
  boot.extraModulePackages = [
    # config.boot.kernelPackages.nvidia_x11
  ];

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/root";
      fsType = "btrfs";
      options = [
        "subvol=root"
        "compress=zstd"
        "noatime"
        "nodiratime"
      ];
    };

    "/home" = {
      device = "/dev/disk/by-label/root";
      fsType = "btrfs";
      options = [
        "subvol=home"
        "compress=zstd"
        "noatime"
        "nodiratime"
      ];
    };

    "/nix" = {
      device = "/dev/disk/by-label/root";
      fsType = "btrfs";
      options = [
        "subvol=nix"
        "compress=zstd"
        "noatime"
        "nodiratime"
      ];
    };

    "/var/log" = {
      device = "/dev/disk/by-label/root";
      fsType = "btrfs";
      options = [
        "subvol=log"
        "compress=zstd"
        "noatime"
        "nodiratime"
      ];
    };

    "/boot" = {
      device = "/dev/disk/by-label/boot";
      fsType = "vfat";
    };

    "/data" = {
      device = "/dev/disk/by-label/data";
      fsType = "btrfs";
      options = [
        "subvol=data"
        "compress=zstd"
        "noatime"
        "nodiratime"
        # "defaults"
        # "user"
        # "uid=1000"
        # "exec"
      ];
    };

    # NFS Shares
    "/mnt/ascaron/media" = {
      device = "10.10.100.100:/media";
      fsType = "nfs";
      options = [
        "x-systemd.automount"
        "noauto"
        "x-systemd.idle-timeout=60"
        "soft"
        # "rsize=1048576"
        # "wsize=1048576"
        # "tcp"
        # "async"
      ];
    };

    "/mnt/ascaron/downloads" = {
      device = "10.10.100.100:/downloads";
      fsType = "nfs";
      options = [
        "x-systemd.automount"
        "noauto"
        "x-systemd.idle-timeout=60"
        "soft"
        # "rsize=1048576"
        # "wsize=1048576"
        # "tcp"
        # "async"
      ];
    };

    "/mnt/ascaron/backup" = {
      device = "10.10.100.100:/backup";
      fsType = "nfs";
      options = [
        "x-systemd.automount"
        "noauto"
        "x-systemd.idle-timeout=60"
        "soft"
      ];
    };

    "/mnt/ascaron/games" = {
      device = "10.10.100.100:/games";
      fsType = "nfs";
      options = [
        "x-systemd.automount"
        "noauto"
        "x-systemd.idle-timeout=60"
        "soft"
      ];
    };
  };

  swapDevices = [{device = "/dev/disk/by-label/swap";}];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
