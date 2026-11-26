{
  self,
  moduleWithSystem,
  ...
}: {
  flake.nixosModules.development = moduleWithSystem ({
    pkgs,
    unfreePkgs,
    ...
  }: {
    imports = with self.nixosModules; [
      git
      neovim
      tmux
    ];
    environment.systemPackages = with pkgs;
      [
        alejandra
        ffmpeg
        htop
        jq
        prek
        tree
      ]
      ++ (with unfreePkgs; [typst]);
  });
}
