{
  config,
  lib,
  pkgs,
  ...
}:

{
  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
    nvidia = {
      # package = config.boot.kernelPackages.nvidiaPackages.latest;
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = true;
      package =
        let
          rcu_patch = pkgs.fetchpatch {
            url = "https://github.com/gentoo/gentoo/raw/c64caf53/x11-drivers/nvidia-drivers/files/nvidia-drivers-470.223.02-gpl-pfn_valid.patch";
            hash = "sha256-eZiQQp2S/asE7MfGvfe6dA/kdCvek9SYa/FFGp24dVg=";
          };
        in
        config.boot.kernelPackages.nvidiaPackages.mkDriver {
          # version = "535.154.05";
          # sha256_64bit = "sha256-fpUGXKprgt6SYRDxSCemGXLrEsIA6GOinp+0eGbqqJg=";
          # sha256_aarch64 = "sha256-G0/GiObf/BZMkzzET8HQjdIcvCSqB1uhsinro2HLK9k=";
          # openSha256 = "sha256-wvRdHguGLxS0mR06P5Qi++pDJBCF8pJ8hr4T8O6TJIo=";
          # settingsSha256 = "sha256-9wqoDEWY4I7weWW05F4igj1Gj9wjHsREFMztfEmqm10=";
          # persistencedSha256 = "sha256-d0Q3Lk80JqkS1B54Mahu2yY/WocOqFFbZVBh+ToGhaE=";

          version = "550.40.07";
          sha256_64bit = "sha256-KYk2xye37v7ZW7h+uNJM/u8fNf7KyGTZjiaU03dJpK0=";
          sha256_aarch64 = "sha256-AV7KgRXYaQGBFl7zuRcfnTGr8rS5n13nGUIe3mJTXb4=";
          openSha256 = "sha256-mRUTEWVsbjq+psVe+kAT6MjyZuLkG2yRDxCMvDJRL1I=";
          settingsSha256 = "sha256-c30AQa4g4a1EHmaEu1yc05oqY01y+IusbBuq+P6rMCs=";
          persistencedSha256 = "sha256-11tLSY8uUIl4X/roNnxf5yS2PQvHvoNjnd2CB67e870=";

          # version = "550.54.14";
          # sha256_64bit = "sha256-jEl/8c/HwxD7h1FJvDD6pP0m0iN7LLps0uiweAFXz+M=";
          # sha256_aarch64 = "sha256-sProBhYziFwk9rDAR2SbRiSaO7RMrf+/ZYryj4BkLB0=";
          # openSha256 = "sha256-F+9MWtpIQTF18F2CftCJxQ6WwpA8BVmRGEq3FhHLuYw=";
          # settingsSha256 = "sha256-m2rNASJp0i0Ez2OuqL+JpgEF0Yd8sYVCyrOoo/ln2a4=";
          # persistencedSha256 = "sha256-XaPN8jVTjdag9frLPgBtqvO/goB5zxeGzaTU0CdL6C4=";

          # version = "550.67";
          # sha256_64bit = "sha256-mSAaCccc/w/QJh6w8Mva0oLrqB+cOSO1YMz1Se/32uI=";
          # sha256_aarch64 = "sha256-+UuK0UniAsndN15VDb/xopjkdlc6ZGk5LIm/GNs5ivA=";
          # openSha256 = "sha256-M/1qAQxTm61bznAtCoNQXICfThh3hLqfd0s1n1BFj2A=";
          # settingsSha256 = "sha256-FUEwXpeUMH1DYH77/t76wF1UslkcW721x9BHasaRUaM=";
          # persistencedSha256 = "sha256-ojHbmSAOYl3lOi2X6HOBlokTXhTCK6VNsH6+xfGQsyo=";

          patches = [ rcu_patch ];
        };
    };
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  environment.systemPackages = with pkgs; [
    hypridle
    hyprlock
    hyprpaper
    xdg-user-dirs
    xdg-utils
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
    LIBVA_DRIVER_NAME = "nvidia";
    XDG_SESSION_TYPE = "wayland";
    # GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };

  programs = {
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
}
