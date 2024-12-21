{config, ...}: {
  services.nginx = {
    enable = true;

    # enable recommended settings
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedTlsSettings = true;
    recommendedProxySettings = true;

    virtualHosts = {
      "keycloak.local" = {
        forceSSL = true;
        enableACME = true;
        locations = {
          "/cloak/" = {
            proxyPass = "http://localhost:${toString config.services.keycloak.settings.http-port}/cloak/";
          };
        };
      };
    };
  };
}
