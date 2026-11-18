{...}: {
  flake.nixosModules.images = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      imv
      gimp
    ];
  };
}
