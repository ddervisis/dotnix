{ config, pkgs, lib, user, ... }:

{
  services.syncthing = {
    enable = false;
    user = user;
    group = "syncthing";
    systemService = true;
    guiAddress = "127.0.0.1:8384";
    extraOptions = {
      gui = {
        theme = "black";
      };
      options = {
        localAnnounceEnabled = false;
      };
    };
    dataDir = "/var/lib/syncthing";
    configDir = "/var/lib/syncthing/.config/syncthing";
    openDefaultPorts = true;
  };
}
