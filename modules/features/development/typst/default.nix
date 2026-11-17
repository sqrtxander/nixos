{...}: {
  flake.nixosModules.development-typst = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      typst
    ];
  };
}
