{pkgs, ...}: {
  services = {
    hardware.openrgb = {
      enable = true;
      package = pkgs.openrgb;
      motherboard = "amd";
      server.port = 6742;
    };
    udev.extraRules = builtins.readFile "${pkgs.openrgb}/lib/udev/rules.d/60-openrgb.rules";
  };
}
