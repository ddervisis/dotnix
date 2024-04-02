{
  config,
  lib,
  pkgs,
  ...
}:

# NOTE: Currently not in use

{
  hardware.opengl = {
    enable = true;
    driSupport = true;
  };

  programs = {
    sway = {
      enable = true;
      extraPackages = with pkgs; [
        autotiling
        swaylock
        swayidle
        wev
        wl-clipboard
        kanshi
      ];
    };
  };
}
