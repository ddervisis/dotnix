{ config, pkgs, lib, ... }:

{
  services.zfs = {
    trim.enable = true;
    autoScrub = {
      enable = true;
      interval = "Mon, 02:00";
      pools = [ "rpool" "storage" "data" ];
    };
    # autoSnapshot = {
    #   enable = true;
    #   frequent = 8; # keep the latest eight 15-minute snapshots (instead of four)
    #   monthly = 1;  # keep only one monthly snapshot (instead of twelve)
    # };
  };
}
