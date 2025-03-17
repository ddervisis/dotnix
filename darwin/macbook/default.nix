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
          { app = "/System/Applications/Launchpad.app/"; }
          { app = "/Applications/Microsoft Outlook.app/"; }
          { app = "/Applications/Microsoft Teams.app/"; }
          { app = "/Applications/Sublime Text.app/"; }
          { app = "/${pkgs.zed-editor}/Applications/Zed.app/"; }
          { app = "/Applications/Bruno.app/"; }
          { app = "/${pkgs.iterm2}/Applications/iTerm2.app/"; }
          { app = "/Applications/Microsoft Remote Desktop.app/"; }
          { app = "/Applications/Arc.app/"; }
          { app = "/${pkgs.spotify}/Applications/Spotify.app/"; }
          { app = "/System/Applications/System Settings.app/"; }
        ];
      };
    };
  };
}
