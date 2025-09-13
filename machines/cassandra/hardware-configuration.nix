{ pkgs, config, ... }:

{
  boot = {
    # secure boot
    lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };
    loader = {
      systemd-boot.enable = false;
      efi.canTouchEfiVariables = true;
    };
    initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "nvme" "usb_storage" "sd_mod" "usbhid" ];
    kernelModules = [ "kvm-intel" ];
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/10d9ceff-c04a-48c0-9a24-d3685d900f5b";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/C3E3-1633";
      fsType = "vfat";
    };
  };
  swapDevices = [ { device = "/dev/disk/by-uuid/cbf1537e-9bc6-463e-86f3-e4ce5ca822c2"; } ];

  environment.systemPackages = with pkgs; [
    libwacom-surface # pen and touch
    sbctl # secure boot utilities
  ];

  hardware.enableAllFirmware = true;

  # snippet stolen from nix wiki for intel igpu acceleration
  #nixpkgs.config.packageOverrides = pkgs: {
  #  intel-vaapi-driver = pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
  #};
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      vpl-gpu-rt
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      intel-vaapi-driver # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      #vaapiVdpau
      libvdpau-va-gl
    ];
  };
  environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; }; # Force intel-media-driver

  services.power-profiles-daemon.enable = false;
  services.tlp = {
    enable = true;
    # settings = {
    #   CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
    #   CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
    #   PLATFORM_PROFILE_ON_AC = "performance";
    #   PLATFORM_PROFILE_ON_BAT = "low-power";
    #   RUNTIME_PM_ON_AC = "on";
    #   RUNTIME_PM_ON_BAT = "auto";
    #   WIFI_PWR = "off";
    #   CPU_SCALING_GOVERNOR_ON_AC = "performance";
    #   CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
    #   CPU_DRIVER_OPMODE = "active";
    #   CPU_HWP_DYN_BOOST = 1;
    #   # i think these are messing up charging with usb-c
    #   #START_CHARGE_THRESH_BAT0 = 75;
    #   #STOP_CHARGE_THRESH_BAT0 = 80;
    # };
  };

  nixpkgs.hostPlatform = "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = config.hardware.enableRedistributableFirmware;
  system.stateVersion = "25.05";
}