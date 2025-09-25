{ ... }:

{
  nix = {
    # check if this breaks anything at some point
    channel.enable = false;
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
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowBroken = true;
  nixpkgs.config.permittedInsecurePackages = [
    #"electron-27.3.11"
    #"olm-3.2.16"
  ];
}