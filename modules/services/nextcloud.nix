{ config, pkgs, lib, ... }:

{
  services.nextcloud = {
    enable = true;
    home = "/data/services/nextcloud";
    datadir = "/storage/cloud";
    hostName = "";
    config = {
      dbuser = "nextcloud";
      dbtype = "pgsql";
      dbport = 5432;
      dbname = "nextcloud";
      dbhost = "localhost";
      adminuser = "root";
      extraTrustedDomains = [
        "cloud.dx-m.de"
        "nextcloud.dx-m.de"
        "dx-m.de"
      ];
    };
    maxUploadSize = "5G";
  };
}

# TODO: run as NixOS container instead of bare metal
# containers.nextcloud = {
#   config =
#     { config, pkgs, ... }:
#     {
#       services.nextcloud = {
#         enable = true;
#       };
#     }
# };
