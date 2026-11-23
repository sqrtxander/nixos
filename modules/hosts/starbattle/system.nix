{
  self,
  moduleWithSystem,
  ...
}: {
  flake.nixosModules.starbattleConfiguration = moduleWithSystem ({
    self',
    pkgs,
    ...
  }: {
    imports = with self.nixosModules; [
      apps
      desktop
      development
      education
      gaming
    ];

    nix.settings.experimental-features = ["nix-command" "flakes"];

    networking.hostName = "starbattle";

    security.pam.services.greetd.fprintAuth = false;
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = ''
            ${pkgs.tuigreet}/bin/tuigreet \
            --cmd ${self'.packages.niri}/bin/niri-session \
            --time
          '';
          user = "greeter";
        };
      };
    };

    # Do not change even when upgrading system
    system.stateVersion = "26.05";
  });
}
