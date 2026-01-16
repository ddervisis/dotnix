{
  pkgs,
  vars,
  ...
}:
{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = ''
          ${pkgs.tuigreet}/bin/tuigreet \
            --time \
            --cmd start-hyprland
        '';
        user = vars.user;
      };
    };
  };

  environment.etc."greetd/environments".text = ''
    Hyprland
  '';
}
