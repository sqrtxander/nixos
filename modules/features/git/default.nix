{
  inputs,
  moduleWithSystem,
  ...
}: {
  flake.nixosModules.git = moduleWithSystem ({self', ...}: {
    programs.git = {
      enable = true;
      package = self'.packages.git;
    };
  });
  perSystem = {pkgs, ...}: {
    packages.git = inputs.wrappers.wrappers.git.wrap {
      inherit pkgs;
      settings = {
        user = {
          name = "Xander James";
          email = "xanderjames128@gmail.com";
        };
        init.defaultBranch = "main";
        pull.rebase = true;
      };
    };
  };
}
