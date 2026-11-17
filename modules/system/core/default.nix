{self, ...}: {
  flake.nixosModules.core = {...}: let
    modules = with self.nixosModules; [
      user
      bootloader
      imports
      locale
    ];
  in {
    imports = modules;
  };
}
