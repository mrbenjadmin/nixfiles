{ config, ... }:

{
  boot.supportedFilesystems = [ "zfs" ];
  boot.zfs.forceImportRoot = false;
  networking.hostId = "912862a4";
  boot.kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
  boot.zfs.extraPools = [ "importantdata" "bigdata" ];
  services.zfs.autoScrub.enable = true;
}