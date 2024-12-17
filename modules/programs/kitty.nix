{ pkgs, ... }:

{
  programs = {
    kitty = {
      enable = true;
      themeFile = "Catppuccin-Macchiato";
      font = {
        package = pkgs.nerd-fonts.fira-code;
        name = "FiraCode Nerd Font";
        size = 12;
      };
      shellIntegration = {
        enableZshIntegration = true;
      };
      settings = {
        confirm_os_window_close = 0;
        scrollback_lines = 10000;
        enable_audio_bell = false;
        update_check_interval = 0;
        resize_debounce_time = "0";
      };
      keybindings = {
        "ctrl+c" = "copy_or_interrupt";
        "ctrl+f>2" = "set_font_size 20";
      };
      # environment = { "LS_COLORS" = "1"; };
      darwinLaunchOptions = [ "--single-instance" ];
    };
  };
}
