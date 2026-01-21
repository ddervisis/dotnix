{
  config,
  pkgs,
  ...
}: {
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    nvidia = {
      # package = config.boot.kernelPackages.nvidiaPackages.latest;
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
        # version = "575.51.02";
        # sha256_64bit = "sha256-XZ0N8ISmoAC8p28DrGHk/YN1rJsInJ2dZNL8O+Tuaa0=";
        # sha256_aarch64 = "sha256-NNeQU9sPfH1sq3d5RUq1MWT6+7mTo1SpVfzabYSVMVI=";
        # openSha256 = "sha256-NQg+QDm9Gt+5bapbUO96UFsPnz1hG1dtEwT/g/vKHkw=";
        # settingsSha256 = "sha256-6n9mVkEL39wJj5FB1HBml7TTJhNAhS/j5hqpNGFQE4w=";
        # persistencedSha256 = "sha256-dgmco+clEIY8bedxHC4wp+fH5JavTzyI1BI8BxoeJJI=";

        # version = "580.65.06";
        # sha256_64bit = "sha256-BLEIZ69YXnZc+/3POe1fS9ESN1vrqwFy6qGHxqpQJP8=";
        # sha256_aarch64 = "sha256-4CrNwNINSlQapQJr/dsbm0/GvGSuOwT/nLnIknAM+cQ=";
        # openSha256 = "sha256-BKe6LQ1ZSrHUOSoV6UCksUE0+TIa0WcCHZv4lagfIgA=";
        # settingsSha256 = "sha256-9PWmj9qG/Ms8Ol5vLQD3Dlhuw4iaFtVHNC0hSyMCU24=";
        # persistencedSha256 = "sha256-ETRfj2/kPbKYX1NzE0dGr/ulMuzbICIpceXdCRDkAxA=";

        version = "580.119.02";
        sha256_64bit = "sha256-gCD139PuiK7no4mQ0MPSr+VHUemhcLqerdfqZwE47Nc=";
        sha256_aarch64 = "sha256-eYcYVD5XaNbp4kPue8fa/zUgrt2vHdjn6DQMYDl0uQs=";
        openSha256 = "sha256-l3IQDoopOt0n0+Ig+Ee3AOcFCGJXhbH1Q1nh1TEAHTE=";
        settingsSha256 = "sha256-sI/ly6gNaUw0QZFWWkMbrkSstzf0hvcdSaogTUoTecI=";
        persistencedSha256 = "sha256-j74m3tAYON/q8WLU9Xioo3CkOSXfo1CwGmDx/ot0uUo=";
      };
    };
  };

  services.xserver.videoDrivers = ["nvidia"];

  environment.systemPackages = with pkgs; [
    hypridle
    hyprlock
    # hyprpaper
    wl-clipboard
    xdg-user-dirs
    xdg-utils
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    LIBVA_DRIVER_NAME = "nvidia";
    XDG_SESSION_TYPE = "wayland";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    OGL_DEDICATED_HW_STATE_PER_CONTEXT = "ENABLE_ROBUST";
  };

  programs = {
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };
}
