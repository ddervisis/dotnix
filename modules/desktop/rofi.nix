{
  config,
  lib,
  pkgs,
  vars,
  ...
}:

let
  inherit (config.lib.formats.rasi) mkLiteral;
in
{
  programs = {
    rofi = {
      package = pkgs.rofi-wayland;
      enable = true;
      terminal = "${pkgs.${vars.terminal}}/bin/${vars.terminal}";
      location = "center";
      theme = {
        "*" = {
          font = "Roboto 12";

          bg0 = mkLiteral "#2E3440F2";
          bg1 = mkLiteral "#3B4252";
          bg2 = mkLiteral "#4C566A80";
          bg3 = mkLiteral "#88C0D0F2";
          fg0 = mkLiteral "#D8DEE9";
          fg1 = mkLiteral "#ECEFF4";
          fg2 = mkLiteral "#D8DEE9";
          fg3 = mkLiteral "#4C566A";

          background-color = mkLiteral "transparent";
          text-color = mkLiteral "@fg0";

          margin = mkLiteral "0px";
          padding = mkLiteral "0px";
          spacing = mkLiteral "0px";
        };

        "window" = {
          transparency = "real";
          fullscreen = false;
          location = mkLiteral "center";
          width = mkLiteral "480";
          border-radius = mkLiteral "24px";

          background-color = mkLiteral "@bg0";
        };

        "mainbox" = {
          padding = mkLiteral "12px";
        };

        "inputbar" = {
          background-color = mkLiteral "@bg1";
          border-color = mkLiteral "@bg3";

          border = mkLiteral "2px";
          border-radius = mkLiteral "16px";

          padding = mkLiteral "8px 16px";
          spacing = mkLiteral "8px";
          children = mkLiteral "[icon-search, entry, case-indicator]";
        };

        "prompt" = {
          text-color = mkLiteral "@fg2";
        };

        "icon-search" = {
          expand = false;
          filename = "search";
          size = mkLiteral "28px";
        };

        "icon-search, entry, element-icon, element-text" = {
          vertical-align = mkLiteral "0.5";
        };

        "textbox-prompt-colon" = {
          expand = false;
          # str = ":";
          text-color = mkLiteral "@fg2";
        };

        "entry" = {
          placeholder = "Search";
          placeholder-color = mkLiteral "@fg3";
        };

        "message" = {
          margin = mkLiteral "12px 0 0";
          border-radius = mkLiteral "16px";
          border-color = mkLiteral "@bg2";
          background-color = mkLiteral "@bg2";
        };

        "textbox" = {
          padding = mkLiteral "8px 24px";
        };

        "listview" = {
          background-color = mkLiteral "transparent";
          margin = mkLiteral "12px 0 0";
          lines = mkLiteral "8";
          columns = mkLiteral "1";
          dynamic = false;
          scrollbar = false;
          fixed-height = false;
        };

        "element" = {
          padding = mkLiteral "8px 16px";
          spacing = mkLiteral "8px";
          border-radius = mkLiteral "16px";
        };

        "element normal active" = {
          text-color = mkLiteral "@bg3";
        };

        "element selected normal, element selected active" = {
          background-color = mkLiteral "@bg3";
        };

        "element selected" = {
          text-color = mkLiteral "@bg1";
        };

        "element-icon" = {
          size = mkLiteral "1em";
          vertical-align = mkLiteral "0.5";
        };

        "element-text" = {
          text-color = mkLiteral "inherit";
        };
      };
    };
  };
}
