{moduleWithSystem, ...}: {
  flake.nixosModules.fonts = moduleWithSystem ({pkgs, ...}: {
    fonts.enableDefaultPackages = true;
    fonts.packages = with pkgs; [
      iosevka
      nerd-fonts.symbols-only
      noto-fonts
      overpass
    ];
  });
}
