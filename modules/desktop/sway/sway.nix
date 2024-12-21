{
  config,
  lib,
  pkgs,
  ...
}:
# NOTE: Currently not in use
{
  hardware.graphics = {
    enable = true;
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
