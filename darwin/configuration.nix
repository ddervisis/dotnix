{
  lib,
  pkgs,
  system,
  vars,
  ...
}:
with lib; {
  users.users.${vars.user} = {
    home = "/Users/${vars.user}";
    shell = pkgs.zsh;
  };

  fonts.packages = with pkgs; [
    carlito
    corefonts
    font-awesome
    ibm-plex
    # jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
    roboto
    source-code-pro
    vegur
  ];

  environment = {
    shells = [pkgs.zsh];
    variables = {
      EDITOR = "${vars.editor}";
      VISUAL = "${vars.editor}";
    };
    pathsToLink = ["/share/qemu"];
    systemPackages = with pkgs; [
      btop
      direnv
      fd
      fzf
      git
      jq
      mkcert
      nil
      nixpkgs-fmt
      pinentry_mac
      pfetch
      podman
      podman-compose
      podman-tui
      qemu
      rectangle
      ripgrep
      spotify
      # stats
    ];

    # For shell debugging purposes:

    # etc."zshenv".text = mkBefore ''
    #   set -x
    # '';
  };

  programs = {
    # needed to have /run/current-system/sw/bin added to the path automatically.
    zsh.enable = true;
    gnupg = {
      agent = {
        enable = true;
        enableSSHSupport = true;
      };
    };
  };

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = false;
      upgrade = false;
      cleanup = "zap";
    };
    brews = ["util-linux"];
    casks = [
      "arc"
      "bitwarden"
      "bruno"
      "itsycal"
      "logitech-options"
      "stats"
      "sublime-text"
    ];
    # These app IDs are from using the mas CLI app
    # mas = mac app store
    # https://github.com/mas-cli/mas
    #
    # $ nix shell nixpkgs#mas
    # $ mas search <app name>
    #
    masApps = {
      "Amphetamine" = 937984704;
    };
  };

  nix = {
    package = pkgs.nix;
    gc = {
      automatic = true;
      interval.Day = 7;
      options = "--delete-older-than 7d";
    };
    extraOptions = ''
      auto-optimise-store = true
      experimental-features = nix-command flakes
    '';
  };

  nixpkgs = {
    hostPlatform = system;
    config = {
      allowUnfree = true;
    };
  };

  system = {
    defaults = {
      NSGlobalDomain = {
        KeyRepeat = 1;
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
      };
      dock = {
        autohide = false;
        orientation = "bottom";
        showhidden = true;
        tilesize = 60;
        persistent-others = ["~/Downloads"];
      };
      finder = {
        _FXShowPosixPathInTitle = false;
        AppleShowAllExtensions = true;
        AppleShowAllFiles = false;
        CreateDesktop = true;
        FXDefaultSearchScope = "SCcf";
        FXEnableExtensionChangeWarning = false;
        FXPreferredViewStyle = "clmv";
        QuitMenuItem = false;
        ShowPathbar = true;
        ShowStatusBar = false;
      };
      trackpad = {
        Clicking = true;
        TrackpadRightClick = true;
      };
    };
    startup = {
      chime = false;
    };
    activationScripts.postActivation.text = "sudo chsh -s ${pkgs.zsh}/bin/zsh";
    stateVersion = 4;
  };
}
