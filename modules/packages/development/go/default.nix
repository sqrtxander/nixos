{...}: {
  flake.nixosModules.development-go = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      go
    ];
  };
}
