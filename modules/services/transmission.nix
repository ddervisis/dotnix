{ config, pkgs, lib, user, ... }:

{
  services.transmission = {
    enable = true;
    user = user;
    openFirewall = true;
    settings = {
      download-dir = "/downloads/complete";
      incomplete-dir = "/downloads/incomplete";
    };
  };
}

# TODO: run as NixOS container instead of bare metal
# containers.transmission = {
#   config =
#     { config, pkgs, ... }:
#     {
#       services.transmission = {
#         enable = true;
#       };
#     }
# };
