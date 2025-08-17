{ pkgs, ... }:

# stuff that doesn't have options should be copied verbatim and referenced via imports
# split out things that wouldn't be useful outside of workstations and live isos at some point

{
  imports = [
    ./desktop.nix
    ./fonts.nix
  ];

  home = {
    stateVersion = "25.05";
    username = "snoofydude";
    homeDirectory = "/home/snoofydude";
    #shell.enableShellIntegration = true;
    packages = with pkgs; [
      # cli utilities
      ## to be sorted
      nano
      pciutils
      usbutils
      lsof
      lshw
      nmap
      traceroute
      unar
      wget
      netcat-gnu
      iftop
      iperf
      tldr
      parallel
      smartmontools
      btop
      bzip3
      powertop
      file
      zip
      vulnix
      iotop
      dig
      inetutils
      pv
      fastfetch
      magic-wormhole
      cloc
      hyperfine
      openssl
      distrobox
      try
      picocom
      minipro
      wiimms-iso-tools
      discordchatexporter-cli
    ];
  };

  programs = {
    fish = { # default shell, might change to nushell or zsh
      enable = true;
    };
    # git stuff, make sure this is enough
    git = {
      enable = true;
      userEmail = "ben.strachan1@gmail.com";
      userName = "mrbenjadmin";
    };
    gh = {
      enable = true;
    };
  };
}