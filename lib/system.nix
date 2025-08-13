{ flakes, pkgs, home-manager, lib, user, ... }:

{ # maybe remove mainrole and replace with separate mkX functions
  mkSystem = { name, arch, mainrole, users, systemConfig }:
    let
      networkCfg = builtins.listToAttrs (map (n: {
        name = "${n}"; value = {};
      }) NICs);
    in
      lib.nixosSystem {
        system = arch; # inherit architecture from machines/${name}

        specialArgs = {
          inherit flakes;
          inherit localModules;
          inherit flakeModules;
        };

        modules = [
          {
            # import hardware config and system-specific fixes
            imports = [ machines/${name} ] ++ users;

            snoof = systemConfig;
          }
        ];
      };
  mkClusterNode = { name, arch, primaryNIC, systemConfig }:
    lib.nixosSystem {
      system = arch;
      
    };
}