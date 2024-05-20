{ pkgs, ... }:

{
  services.keycloak = {
    enable = true;
    package = pkgs.keycloak;
    plugins = [ ];
    settings = { };
  };
}
