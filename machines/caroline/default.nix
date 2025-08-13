{ config, ... }:

{
  # set up lanzaboote for secure boot
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" "sr_mod" ];
    kernelModules = [ "amdgpu" "kvm-intel" ];
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/7f684fc6-373c-4683-9093-16ed593a9136";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/5191-8AE4";
      fsType = "vfat";
    };
  };
  swapDevices = [];

  networking = {
    hostName = "caroline";
    interfaces.eno1.useDHCP = true;
    nameservers = [ "9.9.9.9" ];
    nftables.enable = true;
    firewall.enable = true;
  };

  age.secrets = {
    cacrt = {
      file = ../secrets/ca.crt.age;
      owner = "nebula-snoofnet";
      group = "nebula-snoofnet";
    };
    carolinekey = {
      file = ../secrets/caroline.key.age;
      owner = "nebula-snoofnet";
      group = "nebula-snoofnet";
    };
    carolinecert = {
      file = ../secrets/caroline.crt.age;
      owner = "nebula-snoofnet";
      group = "nebula-snoofnet";
    };
  };
  services.nebula.networks.snoofnet = {
    enable = true;
    ca = config.age.secrets.cacrt.path;
    key = config.age.secrets.carolinekey.path;
    cert = config.age.secrets.carolinecert.path;
    listen.port = 4242;
    tun.device = "snoofnet";
    lighthouses = [ "192.168.69.2" ];
    relays = [ "192.168.69.2" ];
    staticHostMap = {
      "192.168.69.2" = [ "107.189.11.51:4242" ];
    };
    firewall = {
      inbound = [
        # ping
        {
          host = "any";
          port = "any";
          proto = "icmp";
        }
        # ssh
        {
          group = "admin";
          port = 22;
          proto = "tcp";
        }
      ];
      outbound = [ {
        host = "any";
        port = "any";
        proto = "any";
      } ];
    };
    settings = {
      punchy.punch = true;
      preferred_ranges = [ "192.168.2.0/24" ];
      tun = {
        drop_local_broadcast = false;
        drop_multicast = false;
      };
    };
  };
  networking.firewall.trustedInterfaces = [ "snoofnet" ];
  networking.firewall.interfaces.eno1.allowedUDPPorts = [ 4242 ];

  nixpkgs.hostPlatform = "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = config.hardware.enableRedistributableFirmware;
  system.stateVersion = "24.05";
}