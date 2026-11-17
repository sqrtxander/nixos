{...}: {
  flake.nixosModules.development-c = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      gcc
    ];
  };
}
