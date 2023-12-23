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
      # spotify 
      yubioath-flutter
      ripgrep
    ];
  };

  services = { pcscd.enable = true; };
}
