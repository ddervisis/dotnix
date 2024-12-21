{
  config,
  pkgs,
  lib,
  vars,
  ...
}: {
  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad-vpn;
  };
}
