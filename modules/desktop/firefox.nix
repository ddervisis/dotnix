{
  config,
  pkgs,
  lib,
  ...
}:

let
  search = {
    force = true;
    default = "DuckDuckGo";
    privateDefault = "DuckDuckGo";
    order = [
      "DuckDuckGo"
      "Google"
    ];
    engines = {
      "Amazon".metaData.alias = "@a";
      "Bing".metaData.hidden = true;
      "eBay".metaData.hidden = true;
      "Google".metaData.alias = "@g";
      "Wikipedia (en)".metaData.alias = "@w";
      "GitHub" = {
        urls = [
          {
            template = "https://github.com/search";
            params = [
              {
                name = "q";
                value = "{searchTerms}";
              }
            ];
          }
        ];
        icon = "${pkgs.fetchurl {
          url = "https://github.githubassets.com/favicons/favicon.svg";
          sha256 = "sha256-apV3zU9/prdb3hAlr4W5ROndE4g3O1XMum6fgKwurmA=";
        }}";
        definedAliases = [ "@gh" ];
      };
      "Nix Packages" = {
        urls = [
          {
            template = "https://search.nixos.org/packages";
            params = [
              {
                name = "channel";
                value = "unstable";
              }
              {
                name = "query";
                value = "{searchTerms}";
              }
            ];
          }
        ];
        icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
        definedAliases = [ "@np" ];
      };
      "NixOS Wiki" = {
        urls = [
          {
            template = "https://nixos.wiki/index.php";
            params = [
              {
                name = "search";
                value = "{searchTerms}";
              }
            ];
          }
        ];
        icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
        definedAliases = [ "@nw" ];
      };
      "Nixpkgs Issues" = {
        urls = [
          {
            template = "https://github.com/NixOS/nixpkgs/issues";
            params = [
              {
                name = "q";
                value = "{searchTerms}";
              }
            ];
          }
        ];
        icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
        definedAliases = [ "@ni" ];
      };
      "Reddit" = {
        urls = [
          {
            template = "https://www.reddit.com/search";
            params = [
              {
                name = "q";
                value = "{searchTerms}";
              }
            ];
          }
        ];
        icon = "${pkgs.fetchurl {
          url = "https://www.redditstatic.com/accountmanager/favicon/favicon-512x512.png";
          sha256 = "sha256-4zWTcHuL1SEKk8KyVFsOKYPbM4rc7WNa9KrGhK4dJyg=";
        }}";
        definedAliases = [ "@r" ];
      };
      "Youtube" = {
        urls = [
          {
            template = "https://www.youtube.com/results";
            params = [
              {
                name = "search_query";
                value = "{searchTerms}";
              }
            ];
          }
        ];
        icon = "${pkgs.fetchurl {
          url = "www.youtube.com/s/desktop/8498231a/img/favicon_144x144.png";
          sha256 = "sha256-lQ5gbLyoWCH7cgoYcy+WlFDjHGbxwB8Xz0G7AZnr9vI=";
        }}";
        definedAliases = [ "@y" ];
      };
    };
  };
  settings = {
    "app.shield.optoutstudies.enabled" = false;
    "apz.overscroll.enabled" = true;
    "beacon.enabled" = false;
    "browser.contentblocking.category" = "strict";
    "browser.discovery.enabled" = false;
    "browser.display.background_color" = "#F9FAFB";
    "browser.display.foreground_color" = "#111827";
    "browser.display.os-zoom-behavior" = 1;
    "browser.download.dir" = "${config.home.homeDirectory}/Downloads";
    "browser.safebrowsing.malware.enabled" = false;
    "browser.safebrowsing.phishing.enabled" = false;
    "browser.search.suggest.enabled" = false;
    "browser.search.update" = false;
    "browser.send_pings" = false;
    "browser.tabs.closeWindowWithLastTab" = false;
    "browser.tabs.warnOnClose" = false;
    "browser.toolbars.bookmarks.visibility" = "always";
    "browser.uiCustomization.state" = builtins.toJSON {
      placements = {
        widget-overflow-fixed-list = [ ];
        nav-bar = [
          "back-button"
          "forward-button"
          "stop-reload-button"
          "urlbar-container"
          "downloads-button"
          "fxa-toolbar-menu-button"
          # Use the extension uuid in lowercase and replace all non-alpha (and dashes)
          # characters with an underscore (_), then append -browser-action.
          "_testpilot-containers-browser-action" # Multi-Account containers
          "ublock0_raymondhill_net-browser-action" # uBlock Origin
          "addon_darkreader_org-browser-action" # Dark Reader
          "_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action" # Bitwarden
          "jid1-mnnxcxisbpnsxq_jetpack-browser-action" # Privacy Badger
        ];
        toolbar-menubar = [ "menubar-items" ];
        TabsToolbar = [
          "tabbrowser-tabs"
          "new-tab-button"
          "alltabs-button"
        ];
        PersonalToolbar = [ "personal-bookmarks" ];
      };
      dirtyAreaCache = [
        "nav-bar"
        "toolbar-menubar"
        "TabsToolbar"
        "PersonalToolbar"
      ];
      currentVersion = 17;
      newElementCount = 2;
    };
    "browser.uidensity" = 2; # Dense.
    "browser.urlbar.speculativeConnect.enabled" = false;
    "browser.warnOnQuit" = false;
    "datareporting.healthreport.uploadEnabled" = false;
    "datareporting.policy.dataSubmissionEnabled" = false;
    "devtools.selfxss.count" = 5; # Allow pasting into console
    "dom.battery.enabled" = false;
    "dom.security.https_only_mode" = false;
    "experiments.activeExperiment" = false;
    "experiments.enabled" = false;
    "experiments.supported" = false;
    "extensions.formautofill.creditCards.available" = false;
    "extensions.formautofill.creditCards.enabled" = false;
    "extensions.unifiedExtensions.enabled" = false;
    "general.smoothScroll" = true;
    "geo.enabled" = false;
    "gfx.webrender.all" = true;
    "layout.css.devPixelsPerPx" = 1; # Follow system color theme.
    "layout.css.prefers-color-scheme.content-override" = 2;
    "layout.spellcheckDefault" = 1;
    "media.eme.enabled" = true;
    "media.ffmpeg.vaapi.enabled" = true;
    "media.navigator.enabled" = false;
    "media.video_stats.enabled" = false;
    "network.allow-experiments" = false;
    "network.dns.disablePrefetch" = false;
    "network.http.referer.trimmingPolicy" = 1;
    "network.http.referer.XOriginPolicy" = 1;
    "network.http.referer.XOriginTrimmingPolicy" = 1;
    "network.IDN_show_punycode" = true;
    "network.prefetch-next" = false;
    "network.proxy.type" = 0;
    "permissions.default.shortcuts" = 2;
    "privacy.donottrackheader.enabled" = true;
    "privacy.donottrackheader.value" = 1;
    "privacy.firstparty.isolate" = true;
    "services.sync.engine.creditcards" = false;
    "services.sync.engine.passwords" = false;
    "services.sync.engine.prefs" = false;
    "signon.rememberSignons" = false;
    "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
    "toolkit.telemetry.pioneer-new-studies-available" = false;
    "ui.textScaleFactor" = 100;

    # Fully disable Pocket. See
    # https://www.reddit.com/r/linux/comments/zabm2a.
    "extensions.pocket.enabled" = false;
    "extensions.pocket.api" = "0.0.0.0";
    "extensions.pocket.loggedOutVariant" = "";
    "extensions.pocket.oAuthConsumerKey" = "";
    "extensions.pocket.onSaveRecs" = false;
    "extensions.pocket.onSaveRecs.locales" = "";
    "extensions.pocket.showHome" = false;
    "extensions.pocket.site" = "0.0.0.0";
  };
  containers = {
    Personal = {
      color = "blue";
      icon = "fingerprint";
      id = 1;
    };
    Work = {
      color = "orange";
      icon = "briefcase";
      id = 2;
    };
    Banking = {
      color = "green";
      icon = "dollar";
      id = 3;
    };
    Shopping = {
      color = "pink";
      icon = "cart";
      id = 4;
    };
    Social = {
      color = "purple";
      icon = "fence";
      id = 5;
    };
    Development = {
      color = "turquoise";
      icon = "chill";
      id = 6;
    };
  };
in
{
  programs.firefox = {
    enable = true;

    # https://mozilla.github.io/policy-templates/
    policies = {
      AppAutoUpdate = false;
      BackgroundAppUpdate = false;
      Bookmarks = [
        {
          "Title" = "Nix Search";
          "URL" = "https://search.nixos.org/packages";
          "Favicon" = "https://nixos.org/favicon.png";
          "Placement" = "toolbar";
        }
        {
          "Title" = "Nix Wiki";
          "URL" = "https://nixos.wiki/";
          "Favicon" = "https://nixos.wiki/favicon.png";
          "Placement" = "toolbar";
        }
        {
          "Title" = "Home-Manager";
          "URL" = "https://nix-community.github.io/home-manager/options.xhtml";
          "Placement" = "toolbar";
        }
      ];
      Cookies = {
        Behavior = "reject-tracker";
        BehaviorPrivateBrowsing = "reject";
        Locked = true;
      };
      DisableAccounts = true;
      DisableAppUpdate = true;
      DisableBuiltinPDFViewer = false;
      DisableFirefoxAccounts = true;
      DisableFirefoxScreenshots = true;
      DisableFirefoxStudies = true;
      DisableForgetButton = true;
      DisableFormHistory = true;
      DisableMasterPasswordCreation = true;
      DisablePasswordReveal = true;
      DisablePocket = true;
      DisableProfileImport = true;
      DisableProfileRefresh = true;
      DisableSafeMode = true;
      DisableSecurityBypass = {
        InvalidCertificate = false;
        SafeBrowsing = true;
      };
      DisableSetDesktopBackground = true;
      DisableSystemAddonUpdate = true;
      DisableTelemetry = true;
      DisplayBookmarksToolbar = "always";
      DisplayMenuBar = "default-off";
      DontCheckDefaultBrowser = true;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
      ExtensionSettings =
        with builtins;
        let
          extension = shortId: uuid: {
            name = uuid;
            value = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/${shortId}/latest.xpi";
              installation_mode = "normal_installed";
              updates_disabled = true;
              default_area = "menupanel";
            };
          };
        in
        listToAttrs [
          (extension "multi-account-containers" "@testpilot-containers")
          (extension "ublock-origin" "uBlock0@raymondhill.net")
          (extension "darkreader" "addon@darkreader.org")
          (extension "privacy-badger17" "jid1-MnnxcxisBPnSXQ@jetpack")
          (extension "bitwarden-password-manager" "{446900e4-71c2-419f-a6a7-df9c091e268b}")
          (extension "return-youtube-dislikes" "{762f9885-5a13-4abd-9c77-433dcd38b8fd}")
          (extension "sponsorblock" "sponsorBlocker@ajay.app")
          # To add additional extensions, find it on addons.mozilla.org, find
          # the short ID in the url (like https://addons.mozilla.org/en-US/firefox/addon/!SHORT_ID!/)
          # Temporarily install the addon and the navigate to about:support#addons
          # to get the uuid of the addon.
        ];
      ExtensionUpdate = false;
      "3rdparty".Extensions = {
        # "@testpilot-containers".adminSettings = { };
        "uBlock0@raymondhill.net".adminSettings = {
          userSettings = rec {
            uiTheme = "dark";
            uiAccentCustom = true;
            uiAccentCustom0 = "#8300ff";
            cloudStorageEnabled = lib.mkForce false;
            importedLists = [
              "https://filters.adtidy.org/extension/ublock/filters/3.txt"
              "https://github.com/DandelionSprout/adfilt/raw/master/LegitimateURLShortener.txt"
            ];
            externalLists = lib.concatStringsSep "\n" importedLists;
          };
          selectedFilterLists = [
            "ublock-filters"
            "ublock-badware"
            "ublock-privacy"
            "ublock-quick-fixes"
            "ublock-unbreak"

            "adguard-generic"
            "adguard-mobile"
            "easylist"

            "adguard-spyware"
            "adguard-spyware-url"
            "block-lan"
            "easyprivacy"

            "urlhaus-1"
            "curben-phishing"

            "plowe-0"
            "dpollock-0"

            "adguard-mobile-app-banners"
            "adguard-other-annoyances"
            "adguard-popup-overlays"
            "adguard-social"
            "adguard-widgets"

            "adguard-cookies"
            "ublock-cookies-adguard"

            "DEU-0"

            "https://github.com/DandelionSprout/adfilt/raw/master/LegitimateURLShortener.txt"
          ];
        };
      };
      FirefoxHome = {
        Search = false;
        TopSites = false;
        SponsoredTopSites = false;
        Highlights = false;
        Pocket = false;
        SponsoredPocket = false;
        Snippets = false;
        Locked = true;
      };
      FirefoxSuggest = {
        WebSuggestions = false;
        SponsoredSuggestions = false;
        ImproveSuggest = false;
        Locked = true;
      };
      Handlers = {
        # mimeTypes."application/pdf".action = "saveToDisk";
      };
      HardwareAcceleration = true;
      Homepage = {
        Locked = true;
        StartPage = "previous-session";
      };
      ManualAppUpdateOnly = true;
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
      OfferToSaveLoginsDefault = false;
      OverrideFirstRunPage = "";
      OverridePostUpdatePage = "";
      PasswordManagerEnabled = false;
      Permissions = {
        Camera = {
          BlockNewRequests = true;
          Locked = true;
        };
        Microphone = {
          BlockNewRequests = true;
          Locked = true;
        };
        Location = {
          BlockNewRequests = true;
          Locked = true;
        };
        Notifications = {
          BlockNewRequests = true;
          Locked = true;
        };
        Autoplay = {
          Default = "block-audio-video";
          Locked = true;
        };
        VirtualReality = {
          BlockNewRequests = true;
          Locked = true;
        };
      };
      PictureInPicture = {
        Enabled = true;
        Locked = true;
      };
      PopupBlocking = {
        Default = true;
        Locked = true;
      };
      PrimaryPassword = false;
      PrintingEnabled = true;
      SanitizeOnShutdown = {
        Cache = true;
        Cookies = false;
        Downloads = true;
        FormData = true;
        History = false;
        Sessions = false;
        SiteSettings = false;
        OfflineApps = false;
        Locked = true;
      };
      SearchBar = "unified";
      SearchSuggestEnabled = false;
      ShowHomeButton = false;
      StartDownloadsInTempDirectory = true;
      UserMessaging = {
        WhatsNew = false;
        ExtensionRecommendations = false;
        FeatureRecommendations = false;
        UrlbarInterventions = false;
        SkipOnboarding = true;
        MoreFromMozilla = false;
        Locked = true;
      };
      UseSystemPrintDialog = true;
    };

    profiles = {
      default = {
        isDefault = true;
        id = 0;
        inherit search settings;
      };
    };
  };
}
