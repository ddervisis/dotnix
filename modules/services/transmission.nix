{ config, pkgs, lib, user, ... }:

{
  services.transmission = {
    user = user;
    enable = true;
    openFirewall = true;
    settings = {
      download-dir = "/downloads/complete";
      incomplete-dir = "/downloads/complete";
    };
  };
}
