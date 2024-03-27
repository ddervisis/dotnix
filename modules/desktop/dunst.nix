{ config, lib, pkgs, vars, monitors, ... }:

{
  services.dunst = {
    enable = true;
    settings = {
      global = {
        monitor = 0;
        follow = "mouse";
        geometry = "280x50-20+90";
        indicate_hidden = "no";
        shrink = "no";
        separator_height = 4;
        separator_color = "yes";
        padding = 20;
        horizontal_padding = 20;
        frame_width = 3;
        sort = "no";
        idle_threshold = 120;
        font = "Rubik 13";
        line_height = 4;
        markup = "full";
        format = ''
          <b>%s</b>
          %b'';
        alignment = "left";
        show_age_threshold = 60;
        word_wrap = "yes";
        ignore_newline = "no";
        stack_duplicates = false;
        hide_duplicate_count = "yes";
        show_indicators = "no";
        icon_position = "left";
        # icon_path = "/home/end/.config/eww/images/linageOS Icons/1G.png";
        max_icon_size = 48;
        sticky_history = "yes";
        history_length = 20;
        browser = "x-www-browser - new-tab";
        always_run_script = true;
        title = "Dunst";
        class = "Dunst";
        corner_radius = 10;
        origin = "top-right";
        offset = "8x69";
      };

      shortcuts = {
        close = "ctrl+shift+space";
        close_all = "ctrl+shift+space";
        history = "ctrl+grave";
        context = "ctrl+shift+period";
      };

      urgency_low = {
        timeout = 4;
        background = "#1A1B2699";
        foreground = "#A4D7F1";
        frame_color = "#A4D7F1";
      };

      urgency_normal = {
        timeout = 8;
        background = "#1A1B2699";
        foreground = "#A4D7F1";
        frame_color = "#A4D7F1";
      };

      urgency_critical = {
        timeout = 0;
        background = "#1A1B2699";
        foreground = "#FDDC74";
        frame_color = "#FDDC74";
      };
    };
  };
}
