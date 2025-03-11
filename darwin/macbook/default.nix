{
  pkgs,
  config,
  lib,
  vars,
  hostName,
  system,
  ...
}:
{
  environment = {
    systemPackages = with pkgs; [
      gh
      iterm2
      karabiner-elements
      poetry
    ];
  };

  homebrew = {
    brews = [
      "vfkit"
    ];
    taps = [
      "cfergeau/crc"
    ];
    # These app IDs are from using the mas CLI app
    # mas = mac app store
    # https://github.com/mas-cli/mas
    #
    # $ nix shell nixpkgs#mas
    # $ mas search <app name>
    #
    masApps = {
      "Microsoft Remote Desktop" = 1295203466;
    };
  };

  system = {
    defaults = {
      dock = {
        persistent-apps = [
          "/System/Applications/Launchpad.app/"
          "/Applications/Microsoft Outlook.app/"
          "/Applications/Microsoft Teams (work or school).app/"
          "/Applications/Sublime Text.app/"
          "/Applications/Zed.app/"
          "/Applications/Bruno.app/"
          "/${pkgs.iterm2}/Applications/iTerm2.app/"
          "/Applications/Microsoft Remote Desktop.app/"
          "/Applications/Arc.app/"
          "/${pkgs.spotify}/Applications/Spotify.app/"
          "/System/Applications/System Settings.app/"
        ];
      };
    };
  };
}
