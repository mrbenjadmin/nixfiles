final: prev: {

  bitwig-studio-crack = let
    crack = prev.fetchtorrent {
      url = "magnet:?xt=urn:btih:1F55B37CA2C9B96F591573F18D8BDD6D101C3C5E";
      hash = "sha256-FBQflC0PTF8qDV/8xZXMxLKIycIljmoVzjnVGXnHgqs=";
    };
  in 
    prev.bitwig-studio.overrideAttrs rec {
      pname = "bitwig-studio-crack";

      version = "5.0.4";

      src = prev.fetchurl {
        url = "https://downloads.bitwig.com/stable/${version}/bitwig-studio-${version}.deb";
        sha256 = "sha256-IkhUkKO+Ay1WceZNekII6aHLOmgcgGfx0hGo5ldFE5Y=";
      };

      prePatch = ''
        cp "${crack}/Linux/FLARE/bitwig.jar" opt/bitwig-studio/bin/
      '';
    };
}