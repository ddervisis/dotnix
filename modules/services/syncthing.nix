{
  config,
  pkgs,
  lib,
  vars,
  ...
}: {
  services.syncthing = {
    enable = true;
    user = "syncthing";
    group = "syncthing";
    systemService = true;
    guiAddress = "127.0.0.1:8384";
    overrideFolders = false;
    overrideDevices = false;
    settings = {
      gui = {
        theme = "dark";
      };
      options = {
        localAnnounceEnabled = false;
        urAccepted = -1;
      };
    };
  };
}
