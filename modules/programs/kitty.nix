{ pkgs, ... }:

let colors = import ../themes/colors.nix;
in {
  programs = {
    kitty = {
      enable = true;
      theme = "Grape";
      font = {
        package = (pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; });
        name = "FiraCode Nerd Font";
        size = 11;
      };
      shellIntegration = { enableZshIntegration = true; };
      settings = {
        confirm_os_window_close = 0;
        enable_audio_bell = "no";
        resize_debounce_time = "0";
      };
    };
  };
}
