{
  config,
  pkgs,
  vars,
  ...
}:

{
  programs.fuzzel = {
    enable = true;
    package = pkgs.fuzzel;
    settings = {
      main = {
        font = "Roboto:size=12";
        dpi-aware = true;
        # icon-theme = "Papirus-Dark";
        fields = "name,generic,comment,categories,filename,keywords";
        show-actions = true;
        terminal = "${pkgs.${vars.terminal}}/bin/${vars.terminal}";
        anchor = "center";
        width = 25;
        layer = "overlay";
      };
      colors = {
        background = "282a36fa";
        selection = "3d4474fs";
        border = "494d64ff";
      };
      border = {
        radius = 20;
      };
      dmenu = {
        exit-immediately-if-empty = true;
      };
    };
  };
}
