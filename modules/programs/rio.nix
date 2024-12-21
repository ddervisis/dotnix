{
  pkgs,
  vars,
  ...
}: {
  programs.rio = {
    enable = true;
    settings = {
      cursor = "▇";
      line-height = 1.0;
      editor = vars.editor;
      blinking-cursor = false;
      hide-cursor-when-typing = false;
      ignore-selection-foreground-color = false;
      theme = "dracula";
      padding-x = 0;
      option-as-alt = "left";
      confirm-before-quit = false;
      mode = "Maximized";
    };
  };
}
