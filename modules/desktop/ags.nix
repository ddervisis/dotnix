{
  pkgs,
  ags,
  ...
}: {
  programs.ags = {
    enable = true;
    # configDir = ./ags;
    extraPackages = with pkgs; [
      ags.packages.${pkgs.system}.hyprland
    ];
  };
}
