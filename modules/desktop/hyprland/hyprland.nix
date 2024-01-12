{ config, lib, pkgs, ... }:

{
  hardware.opengl = {
    enable = true;
    driSupport = true;
    # nvidia.modesettings.enable = true;
  };

  environment.systemPackages = with pkgs; [
    swayidle
    swaylock
    xdg-user-dirs
    xdg-utils
  ];

  environment.sessionVariables = { NIXOS_OZONE_WL = "1"; };

  programs = {
    hyprland = {
      enable = true;
      xwayland.enable = true;
      # enableNvidiaPatches = true;
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
}