{
  moduleWithSystem,
  inputs,
  ...
}: {
  flake.nixosModules.foot = moduleWithSystem ({self', ...}: {
    environment.systemPackages = with self'.packages; [
      foot
    ];
  });
  perSystem = {pkgs, ...}: {
    packages.foot = let
      iosevka = pkgs.iosevka;
      symbols = pkgs.nerd-fonts.symbols-only;
      font-config = pkgs.makeFontsConf {
        fontDirectories = [iosevka symbols];
      };
    in
      inputs.wrappers.wrappers.foot.wrap {
        inherit pkgs;
        env."FONTCONFIG_FILE" = "${font-config}";
        settings = {
          main.font = "Iosevka:size=12";
        };
      };
  };
}
