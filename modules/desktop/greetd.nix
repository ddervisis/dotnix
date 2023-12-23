{ pkgs, vars, ... }:

{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = ''
          ${pkgs.greetd.tuigreet}/bin/tuigreet \
            --time \
            --cmd Hyprland
        '';
        user = vars.user;
      };
    };
  };

  environment.etc."greetd/environments".text = ''
    Hyprland
  '';
}
