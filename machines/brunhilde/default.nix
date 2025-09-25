{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./zfs.nix
  ];

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
    useDHCP = true;
    interfaces.enp78s0.useDHCP = true;
  };
}