{ nixpkgs, lib, hostName, system, ... }:

let
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };
  hwmon = {
    name = "hwmon4";
    mintemp = "15";
    maxtemp = "40";
    minstart = "130";
    minstop = "90";
  };
in {
  imports = [ (import ./hardware-configuration.nix) ] ++ [
    (import ../../modules/desktop/hyprland/hyprland.nix)
    (import ../../modules/services/syncthing.nix)
    (import ../../modules/desktop/greetd.nix)
  ] ++ (import ../../modules/virtualisation) ++ (import ../../modules/hardware);

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    binfmt.emulatedSystems = [ "aarch64-linux" ];
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 3;
      };
      efi.canTouchEfiVariables = true;
      timeout = 3;
    };
  };

  systemd.enableEmergencyMode = false;

  hardware = {
    opengl = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver
        vaapiIntel
        vaapiVdpau
        libvdpau-va-gl
      ];
    };
    pulseaudio = {
      enable = true;
      support32Bit = true;
    };
    fancontrol = {
      enable = true;
      config = ''
        INTERVAL=10
        DEVPATH=${hwmon.name}=devices/pci0000:00/0000:00:01.2/0000:02:00.0/0000:03:08.0/0000:06:00.3/usb3/3-1/3-1:1.1/0003:0C70:F011.0004
        DEVNAME=${hwmon.name}=octo
        FCTEMPS=${hwmon.name}/pwm1=${hwmon.name}/temp1_input ${hwmon.name}/pwm3=${hwmon.name}/temp1_input ${hwmon.name}/pwm5=${hwmon.name}/temp1_input ${hwmon.name}/pwm7=${hwmon.name}/temp1_input
        FCFANS=${hwmon.name}/pwm1=${hwmon.name}/fan1_input ${hwmon.name}/pwm3=${hwmon.name}/fan3_input ${hwmon.name}/pwm5=${hwmon.name}/fan5_input ${hwmon.name}/pwm7=${hwmon.name}/fan7_input
        MINTEMP=${hwmon.name}/pwm1=${hwmon.mintemp} ${hwmon.name}/pwm3=${hwmon.mintemp} ${hwmon.name}/pwm5=${hwmon.mintemp} ${hwmon.name}/pwm7=${hwmon.mintemp}
        MAXTEMP=${hwmon.name}/pwm1=${hwmon.maxtemp} ${hwmon.name}/pwm3=${hwmon.maxtemp} ${hwmon.name}/pwm5=${hwmon.maxtemp} ${hwmon.name}/pwm7=${hwmon.maxtemp}
        MINSTART=${hwmon.name}/pwm1=${hwmon.minstart} ${hwmon.name}/pwm3=${hwmon.minstart} ${hwmon.name}/pwm5=${hwmon.minstart} ${hwmon.name}/pwm7=${hwmon.minstart}
        MINSTOP=${hwmon.name}/pwm1=${hwmon.minstop} ${hwmon.name}/pwm3=${hwmon.minstop} ${hwmon.name}/pwm5=${hwmon.minstop} ${hwmon.name}/pwm7=${hwmon.minstop}
      '';
    };
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
      awscli
      bitwarden
      jellyfin-media-player
      jq
      lm_sensors
      lutris
      mullvad-vpn
      parted
      ripgrep
      spotify
      teamviewer
      teamspeak5_client
      unzip
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
        general = { renice = 10; };

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
    udev.packages = with pkgs; [ yubikey-personalization ];
    pcscd.enable = true;
    teamviewer.enable = true;
  };

  security.pam.services.hyprlock = { };
}
