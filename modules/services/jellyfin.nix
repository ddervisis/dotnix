{ config, pkgs, lib, user, ... }:

{
  services.jellyfin = {
    enable = false;
    user = user;
    openFirewall = true;
  };
}

# TODO: run as NixOS container instead of bare metal
# containers.jellyfin = {
#   config =
#     { config, pkgs, user, ... }:
#     {
#       services.jellyfin = {
#         enable = true;
#       };
#     }
# };
