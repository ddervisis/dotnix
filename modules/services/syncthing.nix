{ config, pkgs, lib, vars, ... }:

{
  services.syncthing = {
    enable = true;
    user = vars.user;
    group = "syncthing";
    systemService = true;
    guiAddress = "127.0.0.1:8384";
    settings = {
      gui = { theme = "dark"; };
      options = { localAnnounceEnabled = false; };
    };
    dataDir = "/data/services/syncthing";
    configDir = "/data/services/syncthing/.config/";
  };
}
