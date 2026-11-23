{moduleWithSystem, ...}: {
  flake.nixosModules.steam = moduleWithSystem ({
    pkgs,
    unfreePkgs,
    ...
  }: {
    environment.systemPackages = with unfreePkgs; [
      steam
    ];
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      protontricks.enable = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
        libvdpau
      ];
      package = unfreePkgs.steam;
    };
  });
}
