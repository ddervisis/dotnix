{ config, lib, pkgs, vars, monitors, ... }:

{
  programs.eww = {
    enable = true;
    configDir = ../../modules/desktop/eww;
  };
}
