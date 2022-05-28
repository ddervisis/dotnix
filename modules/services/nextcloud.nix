{ config, pkgs, lib, ... }:

{
  services.nextcloud = {
    enable = true;
    datadir = "/cloud";
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
