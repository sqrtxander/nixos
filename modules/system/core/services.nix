{...}: {
  flake.nixosModules.services = {...}: {
    services.upower.enable = true;
    services.power-profiles-daemon.enable = true;
    services.fprintd.enable = true;
    hardware.bluetooth.enable = true;
  };
}
