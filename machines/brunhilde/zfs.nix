{ pkgs, ... }:

{
  boot.supportedFilesystems = [ "zfs" ];
  boot.zfs.forceImportRoot = false;
  networking.hostId = "912862a4";
  #boot.zfs.extraPools = [ "importantdata" "bigdata" ];
  services.zfs.autoScrub.enable = true;
}