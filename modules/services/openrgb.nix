{pkgs, ...}: {
  services = {
    hardware.openrgb = {
      enable = true;
      package = pkgs.openrgb-with-all-plugins;
      motherboard = "amd";
      server.port = 6742;
      startupProfile = "purple";
    };
    udev.extraRules = builtins.readFile "${pkgs.openrgb}/lib/udev/rules.d/60-openrgb.rules";
  };
}
