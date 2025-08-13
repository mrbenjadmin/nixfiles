{ config, ... }:

{
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
    kernelModules = [ "kvm-amd" ];
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/7e817652-7d28-48e4-983f-8c7b4f57c238";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/9AE1-BDDF";
      fsType = "vfat";
    };
  };

  hardware.opengl.enable = true;
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    nvidiaPersistenced = true;
  };
  services.xserver.videoDrivers = [ "nvidia" ];

  networking = {
    hostName = "brunhilde"; # change to automatic from systemconfig name
    # domain = "snoof.ca"; # see about this
  };

  boot.supportedFilesystems = [ "zfs" "ntfs" "ext4" "vfat" ];
  boot.zfs.forceImportRoot = false;
  networking.hostId = "912862a4";
  boot.kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
  boot.zfs.extraPools = [ "importantdata" "bigdata" ];
  services.zfs.autoScrub.enable = true;

  nixpkgs.hostPlatform = "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = config.hardware.enableRedistributableFirmware;
  system.stateVersion = "23.05";
}