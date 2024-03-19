{ nixpkgs, nur, config, lib, vars, hostName, system, ... }:

let
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };
in {
  imports = [ (import ./hardware-configuration.nix) ] ++ [
    (import ../../modules/desktop/hyprland/hyprland.nix)
    (import ../../modules/desktop/greetd.nix)
  ] ++ (import ../../modules/virtualisation) ++ (import ../../modules/hardware);

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 3;
      };
      efi.canTouchEfiVariables = true;
      timeout = 3;
    };
  };

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
        DEVPATH=hwmon4=devices/pci0000:00/0000:00:01.2/0000:02:00.0/0000:03:08.0/0000:06:00.3/usb3/3-1/3-1:1.1/0003:0C70:F011.0001
        DEVNAME=hwmon4=octo
        FCTEMPS=hwmon4/pwm1=hwmon4/temp1_input hwmon4/pwm3=hwmon4/temp1_input hwmon4/pwm5=hwmon4/temp1_input hwmon4/pwm7=hwmon4/temp1_input
        FCFANS=hwmon4/pwm1=hwmon4/fan1_input hwmon4/pwm3=hwmon4/fan3_input hwmon4/pwm5=hwmon4/fan5_input hwmon4/pwm7=hwmon4/fan7_input
        MINTEMP=hwmon4/pwm1=15 hwmon4/pwm3=15 hwmon4/pwm5=15 hwmon4/pwm7=15
        MAXTEMP=hwmon4/pwm1=40 hwmon4/pwm3=40 hwmon4/pwm5=40 hwmon4/pwm7=40
        MINSTART=hwmon4/pwm1=130 hwmon4/pwm3=130 hwmon4/pwm5=130 hwmon4/pwm7=130
        MINSTOP=hwmon4/pwm1=90 hwmon4/pwm3=90 hwmon4/pwm5=90 hwmon4/pwm7=90
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
      # bitwarden
      spotify
      yubioath-flutter
      ripgrep

      lm_sensors
    ];
  };

  services = {
    udev.packages = with pkgs; [ yubikey-personalization ];
    pcscd.enable = true;
  };
}
