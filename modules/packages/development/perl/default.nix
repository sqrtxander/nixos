{...}: {
  flake.nixosModules.development-perl = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      perl
    ];
  };
}
