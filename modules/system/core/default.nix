{self, ...}: {
  flake.nixosModules.core = {...}: let
    modules = with self.nixosModules; [
      user
      bootloader
      imports
      locale
      devDeps
    ];
  in {
    imports = modules;
  };
}
