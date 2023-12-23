{ config, pkgs, nur, vars, ... }:

let
  # nurpkgs = pkgs.unstable.nur.repos;
in {
  programs.firefox = {
    enable = true;
    profiles = {
      ${vars.user} = {
        isDefault = true;
        # extensions = with nur.repos.rycee.firefox-addons; [
        #   ublock-origin
        #   dark-reader
        #   bitwarden
        # ];
        bookmarks = [{
          name = "Nix sites";
          toolbar = true;
          bookmarks = [
            {
              name = "homepage";
              url = "https://nixos.org/";
            }
            {
              name = "wiki";
              tags = [ "wiki" "nix" ];
              url = "https://nixos.wiki/";
            }
          ];
        }];
        search = {
          force = true;
          default = "DuckDuckGo";
          privateDefault = "DuckDuckGo";
          order = [ "DuckDuckGo" "Google" ];
          engines = {
            "Amazon.de".metaData.alias = "@a";
            "Bing".metaData.hidden = true;
            "eBay".metaData.hidden = true;
            "Google".metaData.alias = "@g";
            "Wikipedia (en)".metaData.alias = "@w";
            "GitHub" = {
              urls = [{
                template = "https://github.com/search";
                params = [{
                  name = "q";
                  value = "{searchTerms}";
                }];
              }];
              icon = "${pkgs.fetchurl {
                url = "https://github.githubassets.com/favicons/favicon.svg";
                sha256 = "sha256-apV3zU9/prdb3hAlr4W5ROndE4g3O1XMum6fgKwurmA=";
              }}";
              definedAliases = [ "@gh" ];
            };
            "Nix Packages" = {
              urls = [{
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
              }];
              icon =
                "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "@np" ];
            };
            "NixOS Wiki" = {
              urls = [{
                template = "https://nixos.wiki/index.php";
                params = [{
                  name = "search";
                  value = "{searchTerms}";
                }];
              }];
              icon =
                "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "@nw" ];
            };
            "Nixpkgs Issues" = {
              urls = [{
                template = "https://github.com/NixOS/nixpkgs/issues";
                params = [{
                  name = "q";
                  value = "{searchTerms}";
                }];
              }];
              icon =
                "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "@ni" ];
            };
            # A good way to find genuine discussion
            # "Reddit" = {
            #   urls = [{
            #     template = "https://www.reddit.com/search";
            #     params = [

            #       { name = "q"; value = "{searchTerms}"; }
            #     ];
            #   }];
            #   icon = "${pkgs.fetchurl {
            #     url = "https://www.redditstatic.com/accountmanager/favicon/favicon-512x512.png";
            #     sha256 = "sha256-WiXqffmuCVCOJ/rpqyhFK59bz1lKnUOp9/aoEAYRsn0=";
            #   }}";
            #   definedAliases = [ "@r" ];
            # };
            "Youtube" = {
              urls = [{
                template = "https://www.youtube.com/results";
                params = [{
                  name = "search_query";
                  value = "{searchTerms}";
                }];
              }];
              icon = "${pkgs.fetchurl {
                url =
                  "www.youtube.com/s/desktop/8498231a/img/favicon_144x144.png";
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
          "browser.aboutwelcome.enabled" = false;
          "browser.contentblocking.category" = "strict";
          "browser.discovery.enabled" = false;
          "browser.display.background_color" = "#F9FAFB";
          "browser.display.foreground_color" = "#111827";
          "browser.display.os-zoom-behavior" = 1;
          "browser.download.dir" = "${config.home.homeDirectory}/download";
          "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" =
            false;
          "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" =
            false;
          "browser.newtabpage.activity-stream.feeds.section.highlights" = false;
          "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
          "browser.newtabpage.activity-stream.feeds.snippets" = false;
          "browser.newtabpage.activity-stream.feeds.telemetry" = false;
          "browser.newtabpage.activity-stream.feeds.topsites" = true;
          "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts.havePinned" =
            "google"; # Don't autopin google on first run
          "browser.newtabpage.activity-stream.section.highlights.includePocket" =
            false;
          "browser.newtabpage.activity-stream.showSponsored" = false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
          "browser.newtabpage.activity-stream.telemetry" = false;
          "browser.newtabpage.blocked" = builtins.toJSON {
            # Dismiss builtin shortcuts
            "26UbzFJ7qT9/4DhodHKA1Q==" = 1;
            "4gPpjkxgZzXPVtuEoAL9Ig==" = 1;
            "eV8/WsSLxHadrTL1gAxhug==" = 1;
            "gLv0ja2RYVgxKdp0I5qwvA==" = 1;
            "oYry01JR5qiqP3ru9Hdmtg==" = 1;
            "T9nJot5PurhJSy8n038xGA==" = 1;
          };
          "browser.newtabpage.enabled" = true;
          "browser.safebrowsing.malware.enabled" = false;
          "browser.safebrowsing.phishing.enabled" = false;
          "browser.search.suggest.enabled" = false;
          "browser.search.update" = false;
          "browser.send_pings" = false;
          "browser.shell.checkDefaultBrowser" = false;
          "browser.startup.homepage" = "about:home";
          "browser.startup.page" = 3; # Resume last session.
          "browser.tabs.closeWindowWithLastTab" = false;
          "browser.tabs.warnOnClose" = false;
          "browser.toolbars.bookmarks.visibility" = "newtab";
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
                # Extensions
                "_testpilot-containers-browser-action" # Multi-Account containers
                "ublock0_raymondhill_net-browser-action" # uBlock Origin
                "addon_darkreader_org-browser-action" # Dark Reader
                "_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action" # Bitwarden
              ];
              toolbar-menubar = [ "menubar-items" ];
              TabsToolbar =
                [ "tabbrowser-tabs" "new-tab-button" "alltabs-button" ];
              PersonalToolbar = [ "import-button" "personal-bookmarks" ];
            };
            seen = [
              "save-to-pocket-button"
              "developer-button"
              # Extensions
              # "_testpilot-containers-browser-action" # Multi-Account containers
              # "ublock0_raymondhill_net-browser-action" # uBlock Origin
              # "addon_darkreader_org-browser-action" # Dark Reader
              # "_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action" # Bitwarden
              # "_762f9885-5a13-4abd-9c77-433dcd38b8fd_-browser-action" # Return YouTube Dislike
              # "sponsorBlocker_ajay_app-browser-action" # SponsorBlock for YouTube
              # "_9a41dee2-b924-4161-a971-7fb35c053a4a_-browser-action" # enhanced-h264ify
            ];
            dirtyAreaCache =
              [ "nav-bar" "toolbar-menubar" "TabsToolbar" "PersonalToolbar" ];
            currentVersion = 17;
            newElementCount = 2;
          };
          "browser.uidensity" = 2; # Dense.
          "browser.urlbar.speculativeConnect.enabled" = false;
          "browser.warnOnQuit" = false;
          "datareporting.healthreport.uploadEnabled" = false;
          "datareporting.policy.dataSubmissionEnabled" = false;
          "devtools.selfxss.count" = 5; # Allow pasting into console
          "dom.security.https_only_mode" = true;
          "extensions.formautofill.creditCards.available" = false;
          "extensions.formautofill.creditCards.enabled" = false;
          "layout.spellcheckDefault" = 1;
          "media.eme.enabled" = true;
          "network.proxy.type" = 0;
          "services.sync.engine.creditcards" = false;
          "services.sync.engine.passwords" = false;
          "services.sync.engine.prefs" = false;
          "signon.rememberSignons" = false;
          "toolkit.telemetry.pioneer-new-studies-available" = false;
          "dom.battery.enabled" = false;
          "experiments.activeExperiment" = false;
          "experiments.enabled" = false;
          "experiments.supported" = false;
          "extensions.unifiedExtensions.enabled" = false;
          "general.smoothScroll" = false;
          "geo.enabled" = false;
          "gfx.webrender.all" = true;
          "layout.css.devPixelsPerPx" = 1;
          # Follow system color theme.
          "layout.css.prefers-color-scheme.content-override" = 2;
          "media.ffmpeg.vaapi.enabled" = true;
          "media.navigator.enabled" = false;
          "media.video_stats.enabled" = false;
          "network.IDN_show_punycode" = true;
          "network.allow-experiments" = false;
          "network.dns.disablePrefetch" = true;
          "network.http.referer.XOriginPolicy" = 1;
          "network.http.referer.XOriginTrimmingPolicy" = 1;
          "network.http.referer.trimmingPolicy" = 1;
          "network.prefetch-next" = false;
          "permissions.default.shortcuts" = 2;
          "privacy.donottrackheader.enabled" = true;
          "privacy.donottrackheader.value" = 1;
          "privacy.firstparty.isolate" = true;
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
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
          "browser.newtabpage.activity-stream.pocketCta" = "";
        };
        # containers = {
        #   dangerous = {
        #     color = "red";
        #     icon = "fruit";
        #     id = 2;
        #   };
        #   shopping = {
        #     color = "blue";
        #     icon = "cart";
        #     id = 1;
        #   };
        # };
      };
    };
    # extensions = [
    #   ublock-origin
    #   darkreader
    #   bitwarden
    #   return-youtube-dislikes
    #   sponsorblock
    # ];
  };
}
