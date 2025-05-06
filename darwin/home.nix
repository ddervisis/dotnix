{
  config,
  lib,
  pkgs,
  vars,
  stateVersion,
  ...
}: {
  imports = (import ../modules/editors) ++ (import ../modules/programs) ++ (import ../modules/shell);

  home = {
    username = vars.user;
    homeDirectory = lib.mkForce "/Users/${vars.user}";
    stateVersion = stateVersion;
  };

  programs = {
    home-manager.enable = true;
    zsh = {
      initContent = ''
        eval "$(/opt/homebrew/bin/brew shellenv)"
      '';
    };
  };

  targets = {
    darwin = {
      currentHostDefaults."com.apple.controlcenter".BatteryShowPercentage = true;
      defaults = {
        NSGlobalDomain = {
          AppleLanguages = ["en"];
          AppleLocale = "en_US";
          AppleMeasurementUnits = "Centimeters";
          AppleMetricUnits = true;
          AppleTemperatureUnit = "Celsius";
          NSAutomaticCapitalizationEnabled = false;
          NSAutomaticDashSubstitutionEnabled = true;
          NSAutomaticPeriodSubstitutionEnabled = false;
          NSAutomaticQuoteSubstitutionEnabled = true;
          NSAutomaticSpellingCorrectionEnabled = false;
        };
        "com.apple.Safari" = {
          AutoFillCreditCardData = false;
          AutoFillPasswords = false;
          AutoOpenSafeDownloads = false;
          IncludeDevelopMenu = true;
          ShowOverlayStatusBar = false;
        };
        "com.apple.desktopservices" = {
          DSDontWriteNetworkStores = true;
          DSDontWriteUSBStores = true;
        };
        "com.apple.dock" = {
          expose-group-apps = false;
          size-immutable = true;
          tilesize = 60;
        };
      };
      search = "DuckDuckGo";
    };
  };
}
