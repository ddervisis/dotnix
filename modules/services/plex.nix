{ config, pkgs, lib, user, ... }:

{
  services.plex = {
    dataDir = "/media";
    user = user;
    enable = true;
    openFirewall = true;
  };
}
