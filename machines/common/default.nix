{ flakes, ... }:

{
  imports = [
    ./nix.nix
  ];

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
    };
    openFirewall = false;
  };

  time.timeZone = "America/Toronto";
  i18n.defaultLocale = "en_CA.UTF-8";

  users.mutableUsers = false;
  users.users.root = {
    hashedPassword = "!";
  };

  hardware.enableAllFirmware = true;

  environment.etc."system-revision".text = if (flakes.self ? rev) then flakes.self.rev else "dirty";
}