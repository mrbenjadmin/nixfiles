{ pkgs, home-manager, lib, system, overlays, ... }:

{
  mkUser = { name, groups, uid, shell, ... }:
  {
    users.users."${name}" = {
      inherit name;
    };
  };
}