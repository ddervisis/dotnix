{ config, pkgs, lib, ... }:

{
  services.minio = {
    enable = false;

    region = "eu-west-1";
    browser = true;

    accessKey = "";
    secretKey = "";

    listenAddress = ":9000";
    consoleAddress = ":9001";

    dataDir = [
      "/var/lib/minio/data"
    ];
    configDir = "var/lib/minio/config";
  };
}

# TODO: run as NixOS container instead of bare metal
# containers.minio = {
#   config =
#     { config, pkgs, ... }:
#     {
#       services.minio = {
#         enable = true;
#       };
#     }
# };
