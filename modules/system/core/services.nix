{...}: {
  flake.nixosModules.services = {...}: {
    services.upower.enable = true;
    services.power-profiles-daemon.enable = true;
    hardware.bluetooth.enable = true;
  };
}
