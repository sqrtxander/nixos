{self, ...}: {
  flake.nixosModules.core = {...}: let
    modules = with self.nixosModules; [
      user
      bootloader
      imports
      locale
      services
      printing
    ];
  in {
    imports = modules;
  };
}
