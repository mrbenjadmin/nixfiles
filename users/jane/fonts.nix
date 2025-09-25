{ pkgs, ... }:

{
  fonts.fontconfig = {
    enable = true;
  };

  home.packages = with pkgs; [
    # need some nice geometric font at some point, also pc98 japanese
    # need global fonts at some point too
    # also global motd but that's not relevant here
    cozette
    ultimate-oldschool-pc-font-pack
    apl386
    atkinson-hyperlegible
    departure-mono
  ];
}