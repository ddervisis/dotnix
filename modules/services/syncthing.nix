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
    dataDir = "/data/services/syncthing";
    configDir = "/data/services/syncthing/.config/syncthing";
    openDefaultPorts = true;
  };
}

# TODO: run as NixOS container instead of bare metal
# containers.syncthing = {
#   config =
#     { config, pkgs, user, ... }:
#     {
#       services.syncthing = {
#         enable = false;
#       };
#     }
# };
