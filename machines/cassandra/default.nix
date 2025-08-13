{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./desktop.nix
  ];

  # this stuff to be moved to common
  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
    };
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [ "root" "@wheel" ];
      auto-optimise-store = true;
    };
  };
  nixpkgs.config = {
    allowUnfree = true;
    #allowBroken = true;
    permittedInsecurePackages = [
      "olm-3.2.16"
    ];
  };
  
  time.timeZone = "America/Toronto";
  i18n.defaultLocale = "en_CA.UTF-8";

  users = { 
    mutableUsers = false;
    users.root = {
      hashedPassword = "!";
    };
  };
  # end of stuff to be moved to common

  networking = {
    hostName = "cassandra";
    interfaces.wlp242s0.useDHCP = true;
    nameservers = [ "9.9.9.9" ];
    nftables.enable = true;
    firewall = {
      enable = true;
      # for nebula
      #trustedInterfaces = [ "snoofnet" ];
      #interfaces.wlp242s0.allowedUDPPorts = [ 4242 ];
    };
    # wifi SUCKS without networkmanager
    networkmanager = {
      enable = true;
      wifi.powersave = false;
    };
  };

  # all virt from here
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
        ovmf.enable = true;
      };
    };
    containers.enable = true;
    podman = {
      enable = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };
  # change this to be more generic probably, maybe just tack onto wheel
  users.users.snoofydude.extraGroups = [ "libvirtd" ];

  environment.systemPackages = with pkgs; [ virtiofsd podman-tui podman-compose dive ];
}