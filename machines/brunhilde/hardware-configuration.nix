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
      device = "/dev/disk/by-uuid/7e817652-7d28-48e4-983f-8c7b4f57c238";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/9AE1-BDDF";
      fsType = "vfat";
    };
  };

  boot.supportedFilesystems = [ "ntfs" "ext4" "vfat" ];

  nixpkgs.hostPlatform = "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = config.hardware.enableRedistributableFirmware;
  system.stateVersion = "25.05";
}