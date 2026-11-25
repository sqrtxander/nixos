{
  self,
  moduleWithSystem,
  ...
}: {
  flake.nixosModules.apps = moduleWithSystem ({
    inputs',
    pkgs,
    unfreePkgs,
  }: {
    imports = with self.nixosModules; [
      fonts
      foot
      librewolf
      zsh
    ];
    environment.systemPackages =
      [
        inputs'.helium.packages.default
      ]
      ++ (with pkgs; [
        gimp
        imv
        zathura
      ])
      ++ (with unfreePkgs; [
        discord
        insync
      ]);
  });
}
