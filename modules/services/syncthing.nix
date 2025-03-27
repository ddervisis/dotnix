{...}: {
  # SeeAlso: https://nix-community.github.io/home-manager/options.xhtml#opt-services.syncthing.enable
  services.syncthing = {
    enable = true;
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
