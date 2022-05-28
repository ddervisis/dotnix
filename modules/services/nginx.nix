{ config, pkgs, lib, ... }:

let
  hostName = "tbd.ts.net";
in
{
  services.nginx = {
    enable = true;
    virtualHosts."${hostName}" = {
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://127.0.0.1:32400";
        proxyWebsockets = true;
      };
      locations."/transmission" = {
        proxyPass = "http://127.0.0.1:9091";
        proxyWebsockets = true;
      };
      sslCertificate = "/srv/within/certs/${hostName}.crt";
      sslCertificateKey = "/srv/within/certs/${hostName}.key";
    };
  };
}
