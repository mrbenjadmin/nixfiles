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
  
  # perhaps we should be moving storage and persistence to a separate file across the board
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/d424a0d7-3639-4ac9-97a4-1efe4bd5a248";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/B73E-71D6";
      fsType = "vfat";
    };
  };

  boot.supportedFilesystems = [ "ntfs" "ext4" "vfat" ];

  nixpkgs.hostPlatform = "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = config.hardware.enableRedistributableFirmware;
  system.stateVersion = "25.05";
}