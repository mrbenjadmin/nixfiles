{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      # this all needs sorted and labelled
      # perhaps we could be using direnv or shells for project programs?
      audacity
      handbrake
      fontforge-gtk
      libreoffice
      nicotine-plus
      qbittorrent
      # art
      krita
      libresprite
      grafx2
      openhantek6022
      qpwgraph
      ksnip
      sonobus
      leocad
      scribus
      sabnzbd
      logseq
      anki
      obsidian
      kicad
      freecad
      openscad
      gitkraken # needs replaced with a foss solution ideally
      quodlibet-full # potentially going to replace due to aesthetics, look into theming
      moonlight-qt
      vlc
      milkytracker
      pt2-clone
      cardinal # virtual modular rack
      mixxx
      carla # unsure if we need this still
      zrythm
      bitwig-studio-crack
      # wine stuff, unsure if we want this yet
      #wineWowPackages.stableFull
      #wineWowPackages.waylandFull
      #winetricks
      #yabridge
      #yabridgectl
      telegram-desktop
      signal-desktop
      dino # for xmpp? maybe? i forget, unsure if keeping
      # need an irc client and a newsreader
      teams-for-linux # does this even work?
      virt-manager
    ];
  };

  # look into replacing terminal emulator at some point, maybe kitty?

  programs = {
    firefox = { # eventually immutable extensions and config
      enable = true;
    };
    vscode = { # eventually immutable extensions and config
      enable = true;
      package = pkgs.vscodium;
    };
    #thunderbird = { # fully declarative at some point, unsure if keeping
    #  enable = true;
    #  # thunderbird.profiles was accessed but has no value defined. Try setting the option.
    #};
    nheko = { # fully declarative at some point
      enable = true;
    };
    #vesktop = { # fully declarative at some point
    #  enable = true;
    #};
  };
}