{
  moduleWithSystem,
  inputs,
  ...
}: {
  flake.nixosModules.tmux = moduleWithSystem ({self', ...}: {
    environment.systemPackages = with self'.packages; [
      tmux
    ];
  });
  perSystem = {
    pkgs,
    lib,
    ...
  }: {
    packages.tmux = let
      openGithub = pkgs.writeShellApplication {
        name = "open-github";
        runtimeInputs = with pkgs; [
          bash
          git
          tmux
          xdg-utils
        ];
        text = builtins.readFile ./open-github.sh;
      };
    in
      inputs.wrappers.wrappers.tmux.wrap {
        inherit pkgs;
        configBefore =
          (builtins.readFile ./tmux.conf)
          + ''
            bind g run-shell "${lib.getExe openGithub}"
          '';
      };
  };
}
