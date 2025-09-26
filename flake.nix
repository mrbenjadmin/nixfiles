{
  description = "SnoofNET Infrastructure";

  inputs = {
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    flake-utils.url = "github:numtide/flake-utils";

    #impermanence.url = "github:nix-community/impermanence"; # use later
    #disko.url = "github:nix-community/disko"; # use for sbcs sometime
    agenix.url = "github:ryantm/agenix"; # replace with homerolled solution when possible
    deploy-rs.url = "github:serokell/deploy-rs";

    # secure boot! wooooooooooo
    lanzaboote.url = "github:nix-community/lanzaboote/v0.4.2";

    # this is mostly for the surface stuff
    nixos-hardware.url = "github:NixOS/nixos-hardware";

    #mailserver.url = gitlab:simple-nixos-mailserver/nixos-mailserver;

    # mac stuff
    #nix-darwin = {
    #  url = "github:LnL7/nix-darwin";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};
  };

  outputs = {
    self,
    nixpkgs-stable,
    nixpkgs-unstable,
    agenix,
    deploy-rs,
    lanzaboote,
    nixos-hardware,
    home-manager,
    ...
  }@flakes: {
    nixosConfigurations = {
      cassandra = nixpkgs-stable.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = flakes;
        modules = [
          ./machines/cassandra
          nixos-hardware.nixosModules.microsoft-surface-pro-intel
          lanzaboote.nixosModules.lanzaboote
          {
            users.users.jane = {
              description = "Jane Strachan";
              isNormalUser = true;
              extraGroups = [ "wheel" ];
              hashedPassword = "$y$j9T$i9JMWwTrdtSLZ3AQxWaCk1$AeLZzZcBZa4Fm2pOCVEhT56EVChPIIG5tFtn5P6LkL4";
            };
          }
          home-manager.nixosModules.home-manager {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = flakes;
              users.jane = import ./users/jane;
            };
          }
        ];
      };
      brunhilde = nixpkgs-stable.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = flakes;
        modules = [
          ./machines/common
          ./machines/brunhilde
          #lanzaboote.nixosModules.lanzaboote
          {
            users.users.jane = {
              description = "Jane Strachan";
              isNormalUser = true;
              extraGroups = [ "wheel" "libvirt" ];
              hashedPassword = "$y$j9T$i9JMWwTrdtSLZ3AQxWaCk1$AeLZzZcBZa4Fm2pOCVEhT56EVChPIIG5tFtn5P6LkL4";
              openssh.authorizedKeys.keys = [ # check if theres a home-manager for this
                "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOZ3HkB/NJXpNFjLGXLw6CwmL+vYeoVmRH1mykIZgJBV snoofydude@caroline"
              ];
            };
          }
          # this needs to be given args so it doesn't install desktop apps
          home-manager.nixosModules.home-manager {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = flakes;
              users.jane = import ./users/jane;
            };
          }
        ];
      };
    };
  };
}