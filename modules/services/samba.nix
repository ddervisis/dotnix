{ config, pkgs, user, ... }:

{
  # https://nixos.wiki/wiki/Samba
  services.samba = {
    enable = true;
    securityType = "user";
    extraConfig = ''
      workgroup = WORKGROUP
      server string = itsuki
      netbios name = itsuki
      security = user
      use sendfile = yes
      #max protocol = smb2
      hosts allow = 0.0.0.0/0
      hosts deny = 0.0.0.0/0
      guest account = nobody
      map to guest = bad user
    '';
    shares = {
      data = {
        path = "/data";
        browseable = "yes";
        "read only" = "no";
        "guest ok" = "yes";
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = user;
        "force group" = "within";
      };
      tm_share = {
          path = "/data/timecapsule";
          "valid users" = user;
          public = "no";
          writeable = "yes";
          "force user" = user;
          "fruit:aapl" = "yes";
          "fruit:time machine" = "yes";
          "vfs objects" = "catia fruit streams_xattr";
      };
    };
    openFirewall = true;
  };
}

# TODO: run as NixOS container instead of bare metal
# containers.samba = {
#   config =
#     { config, pkgs, ... }:
#     {
#       services.samba = {
#         enable = true;
#       };
#     }
# };
