{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    #./zfs.nix # kill for now, just until we get drives plugged in
    ./virtualisation.nix
  ];

  hardware.graphics.enable = true;
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
    # enp81s0 - Intel 2.5Gbit/s NIC, leftmost on motherboard
    # enp78s0 - Realtek 2.5Gbit/s NIC, rightmost on motherboard
    hostName = "brunhilde"; # change to automatic from systemconfig name
    # domain = "snoof.ca"; # see about this
    nameservers = [ "9.9.9.9" ];
    defaultGateway = "192.168.2.1";
    bridges.virbr0.interfaces = [ "enp78s0" ];
    interfaces.virbr0 = {
      virtual = true;
      ipv4.addresses = [{
        address = "192.168.2.10";
        prefixLength = 24;
      }];
    };

    #nftables.enable = true;
    firewall.enable = false; # for now
  };
}