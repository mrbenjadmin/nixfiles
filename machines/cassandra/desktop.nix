{ pkgs, ... }:

  # REPLACE GNOME AT SOME POINT

{
  services.xserver = {
    enable = true;
    xkb.layout = "us";
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };
  gtk.iconCache.enable = false; # fix icons not showing up GNOME

  environment.systemPackages = with pkgs; [
    #gnome-osk # on screen keyboard
    gnome-tweaks
    gnomeExtensions.pop-shell
    gnomeExtensions.tray-icons-reloaded
    dconf-editor
  ];

  # on screen keyboard crap, probably needs fixed
  #services.displayManager.environment.XDG_DATA_DIRS = ":${pkgs.gnome-osk}/share:";
  #services.xserver.desktopManager.gnome.extraGSettingsOverrides = ''
  #  [org.gnome.shell]
  #  enabled-extensions=[ '${pkgs.gnome-osk.uuid}' ]
  #'';
  #programs.dconf.profiles.gdm.databases = [
  #  {
  #    settings."org/gnome/shell/extensions/enhancedosk" = {
  #      show-statusbar-icon = true;
  #      locked = true;
  #    };
  #  }
  #  {
  #    settings."org/gnome/shell" = {
  #      enabled-extensions = [ "iwanders-gnome-enhanced-osk-extension" ];
  #    };
  #  }
  #];

  # pen and touch calibration
  services.iptsd = {
    enable = true;
    config = {
      Touchscreen.DisableOnStylus = true;
      Contacts = {
        SizeMin = 0.787;
        SizeMax = 1.954;
        AspectMin = 1.021;
        AspectMax = 2.172;
      };
    };
  };

  # gnome application exclusion
  environment.gnome.excludePackages = with pkgs; [
    epiphany
    gnome-tour
    xterm
    gnome-maps
    gnome-weather
    gnome-contacts
    gnome-music
    gnome-calendar
    totem
    yelp
    gnome-system-monitor
    geary
  ];

  # qt theming
  qt = {
    enable = true;
    style = "adwaita-dark";
    platformTheme = "gnome";
  };

  # wayland go brr
  environment.sessionVariables = {
    GDK_BACKEND = "wayland";
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    NIXOS_OZONE_WL = "1";
  };

  services.printing.enable = true;

  # audio!
  hardware.pulseaudio.enable = false; # change to services.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };
}