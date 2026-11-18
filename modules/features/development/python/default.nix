{...}: {
  flake.nixosModules.development-python = {
    lib,
    pkgs,
    ...
  }: {
    environment.systemPackages = with pkgs; [
      python315
    ];
  };
}
