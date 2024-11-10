{
  nixpkgs,
  lib,
  hostName,
  system,
  talhelper,
  ...
}:

let
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };
  hwmon = {
    path = "/dev/hwmon";
    mintemp = "15";
    maxtemp = "40";
    minstart = "130";
    minstop = "90";
  };
in
{
  imports =
    [ (import ./hardware-configuration.nix) ]
    ++ [
      (import ../../modules/desktop/hyprland/hyprland.nix)
      (import ../../modules/services/syncthing.nix)
      (import ../../modules/services/mullvad.nix)
      (import ../../modules/desktop/greetd.nix)
    ]
    ++ (import ../../modules/virtualisation)
    ++ (import ../../modules/hardware);

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [ "nvidia-drm.fbdev=1" ];
    # binfmt.emulatedSystems = [ "aarch64-linux" ];
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 5;
      };
      efi.canTouchEfiVariables = true;
      timeout = 3;
    };
  };

  systemd.enableEmergencyMode = false;

  hardware = {
    graphics = {
      enable = true;
    };
    alsa.enablePersistence = true;
    fancontrol = {
      enable = true;
      config = ''
        INTERVAL=10
        FCTEMPS=${hwmon.path}/pwm1=${hwmon.path}/temp1_input ${hwmon.path}/pwm3=${hwmon.path}/temp1_input ${hwmon.path}/pwm5=${hwmon.path}/temp1_input ${hwmon.path}/pwm7=${hwmon.path}/temp1_input
        FCFANS=${hwmon.path}/pwm1=${hwmon.path}/fan1_input ${hwmon.path}/pwm3=${hwmon.path}/fan3_input ${hwmon.path}/pwm5=${hwmon.path}/fan5_input ${hwmon.path}/pwm7=${hwmon.path}/fan7_input
        MINTEMP=${hwmon.path}/pwm1=${hwmon.mintemp} ${hwmon.path}/pwm3=${hwmon.mintemp} ${hwmon.path}/pwm5=${hwmon.mintemp} ${hwmon.path}/pwm7=${hwmon.mintemp}
        MAXTEMP=${hwmon.path}/pwm1=${hwmon.maxtemp} ${hwmon.path}/pwm3=${hwmon.maxtemp} ${hwmon.path}/pwm5=${hwmon.maxtemp} ${hwmon.path}/pwm7=${hwmon.maxtemp}
        MINSTART=${hwmon.path}/pwm1=${hwmon.minstart} ${hwmon.path}/pwm3=${hwmon.minstart} ${hwmon.path}/pwm5=${hwmon.minstart} ${hwmon.path}/pwm7=${hwmon.minstart}
        MINSTOP=${hwmon.path}/pwm1=${hwmon.minstop} ${hwmon.path}/pwm3=${hwmon.minstop} ${hwmon.path}/pwm5=${hwmon.minstop} ${hwmon.path}/pwm7=${hwmon.minstop}
      '';
    };
    xone.enable = true;
  };

  networking = {
    useDHCP = lib.mkDefault true;
    hostName = hostName;
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 ];
    };
  };

  environment = {
    systemPackages = with pkgs; [
      age
      awscli
      cifs-utils
      discord
      goverlay
      jellyfin-media-player
      jq
      lm_sensors
      lutris
      mangohud
      parted
      prismlauncher
      r2modman
      ripgrep
      spotify
      sops
      tailscale
      teamspeak5_client
      teamviewer
      unzip
      wineWowPackages.waylandFull
      yubikey-manager
      zed-editor
    ];
  };

  programs = {
    steam = {
      enable = true;
      gamescopeSession.enable = true;
    };
    gamescope.enable = true;
    gamemode = {
      enable = true;
      enableRenice = true;
      settings = {
        general = {
          renice = 10;
        };

        # Warning: GPU optimisations have the potential to damage hardware
        # gpu = {
        #   apply_gpu_optimisations = "accept-responsibility";
        #   gpu_device = 0;
        #   amd_performance_level = "high";
        # };

        custom = {
          start = "${pkgs.libnotify}/bin/notify-send 'GameMode started'";
          end = "${pkgs.libnotify}/bin/notify-send 'GameMode ended'";
        };
      };
    };
  };

  services = {
    udev = {
      packages = with pkgs; [ yubikey-personalization ];
      extraRules = ''
        ACTION=="add", SUBSYSTEM=="hwmon", ATTRS{name}=="octo", RUN+="/bin/sh -c 'ln -s /sys$devpath /dev/hwmon'"
      '';
    };
    pcscd.enable = true;
    teamviewer.enable = true;
    tailscale.enable = true;
    printing.enable = true;
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };

  security.pam.services.hyprlock = { };
}
