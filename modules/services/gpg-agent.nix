{
  config,
  pkgs,
  lib,
  vars,
  ...
}: {
  services.gpg-agent = {
    enable = true;
    enableScDaemon = true;
    enableSshSupport = true;
    enableZshIntegration = true;
    extraConfig = ''
      # https://github.com/drduh/config/blob/master/gpg-agent.conf
      # https://www.gnupg.org/documentation/manuals/gnupg/Agent-Options.html
      pinentry-program ${pkgs.pinentry-curses}/bin/pinentry-curses
      ttyname $GPG_TTY
      default-cache-ttl 60
      max-cache-ttl 120
    '';
  };
}
