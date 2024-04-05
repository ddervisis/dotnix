{ pkgs, lib, ... }:

{
  programs.gpg = {
    enable = true;
    mutableKeys = true;
    mutableTrust = true;
  };
}
