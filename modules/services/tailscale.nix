{ config, pkgs, lib, ... }:

{
  services.tailscale = {
    enable = true;
  };
}

# TODO: run as NixOS container instead of bare metal
# containers.tailscale = {
#   config =
#     { config, pkgs, ... }:
#     {
#       services.tailscale = {
#         enable = true;
#       };
#     }
# };
