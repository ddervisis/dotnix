{ config, pkgs, lib, user, ... }:

{
  services.plex = {
    dataDir = "/storage/media";
    user = user;
    enable = true;
    openFirewall = true;
  };
}

# TODO: run as NixOS container instead of bare metal
# containers.plex = {
#   config =
#     { config, pkgs, user, ... }:
#     {
#       services.plex = {
#         enable = true;
#       };
#     }
# };
