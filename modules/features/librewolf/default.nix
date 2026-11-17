{moduleWithSystem, ...}: {
  flake.nixosModules.librewolf = moduleWithSystem ({pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      librewolf
    ];
  });
}
