{
  inputs,
  moduleWithSystem,
  ...
}: {
  flake.nixosModules.niri = moduleWithSystem ({
    self',
    pkgs,
    ...
  }: {
    programs = {
      niri = {
        enable = true;
        package = self'.packages.niri;
      };
      xwayland.enable = true;
    };
    systemd.user.services.niri.enableDefaultPath = false;
    environment.systemPackages = with pkgs; [
      mako
      libnotify
      xwayland-satellite
      bibata-cursors
    ];
  });
  perSystem = {
    pkgs,
    unfreePkgs,
    lib,
    self',
    ...
  }: let
    noctaliaExe = lib.getExe self'.packages.noctalia;
    wallpaperScript = pkgs.writeShellApplication {
      name = "wallpaper-switch";
      runtimeInputs = [
        inputs.wallpaper-generator.packages.${pkgs.stdenv.hostPlatform.system}.default
        pkgs.jq
        self'.packages.noctalia
      ];
      text = builtins.readFile ./wallpaper-switch.sh;
    };
    niri-wrapped = inputs.wrappers.wrappers.niri.wrap {
      inherit pkgs;
      settings = {
        prefer-no-csd = _: {};

        spawn-at-startup = [
          noctaliaExe
          "${lib.getExe unfreePkgs.insync} start"
        ];

        hotkey-overlay.skip-at-startup = _: {};

        input = {
          keyboard = {
            xkb.options = "compose:ralt";
            numlock = _: {};
          };
          touchpad = {
            tap = _: {};
            natural-scroll = _: {};
          };
          warp-mouse-to-focus = _: {};
        };

        cursor.xcursor-theme = "Bibata-Modern-Classic";

        layout = {
          gaps = 5;
          focus-ring = {
            width = 2;
            active-color = "#5ef1ff";
            inactive-color = "#7b8496";
          };
        };

        gestures.hot-corners.off = _: {};

        window-rules = [
          {
            geometry-corner-radius = 5;
            clip-to-geometry = true;
          }
        ];

        switch-events = {
          lid-close.spawn = [
            noctaliaExe
            "msg"
            "session"
            "lock-and-suspend"
          ];
        };

        binds = {
          "Mod+Return".spawn-sh = lib.getExe self'.packages.foot;
          "Mod+B".spawn-sh = lib.getExe pkgs.librewolf;
          "Mod+Q".close-window = _: {};
          "Mod+R".spawn-sh = "${noctaliaExe} msg panel-toggle launcher";
          "Mod+O".toggle-overview = _: {};
          "Mod+X".spawn-sh = "${noctaliaExe} msg session lock";
          "Mod+W".spawn-sh = "${lib.getExe wallpaperScript} >> /tmp/wallpaper-generator.log";

          "Mod+H".focus-column-left = _: {};
          "Mod+J".focus-window-down = _: {};
          "Mod+K".focus-window-up = _: {};
          "Mod+L".focus-column-right = _: {};
          "Mod+Shift+H".move-column-left = _: {};
          "Mod+Shift+J".move-window-down = _: {};
          "Mod+Shift+K".move-window-up = _: {};
          "Mod+Shift+L".move-column-right = _: {};
          "Mod+Ctrl+H".focus-monitor-left = _: {};
          "Mod+Ctrl+J".focus-monitor-down = _: {};
          "Mod+Ctrl+K".focus-monitor-up = _: {};
          "Mod+Ctrl+L".focus-monitor-right = _: {};
          "Mod+Shift+Ctrl+H".move-column-to-monitor-left = _: {};
          "Mod+Shift+Ctrl+J".move-column-to-monitor-down = _: {};
          "Mod+Shift+Ctrl+K".move-column-to-monitor-up = _: {};
          "Mod+Shift+Ctrl+L".move-column-to-monitor-right = _: {};

          "Mod+1".focus-workspace = 1;
          "Mod+2".focus-workspace = 2;
          "Mod+3".focus-workspace = 3;
          "Mod+4".focus-workspace = 4;
          "Mod+5".focus-workspace = 5;
          "Mod+6".focus-workspace = 6;
          "Mod+7".focus-workspace = 7;
          "Mod+8".focus-workspace = 8;
          "Mod+9".focus-workspace = 9;
          "Mod+0".focus-workspace = 0;

          "Mod+Shift+1".move-column-to-workspace = 1;
          "Mod+Shift+2".move-column-to-workspace = 2;
          "Mod+Shift+3".move-column-to-workspace = 3;
          "Mod+Shift+4".move-column-to-workspace = 4;
          "Mod+Shift+5".move-column-to-workspace = 5;
          "Mod+Shift+6".move-column-to-workspace = 6;
          "Mod+Shift+7".move-column-to-workspace = 7;
          "Mod+Shift+8".move-column-to-workspace = 8;
          "Mod+Shift+9".move-column-to-workspace = 9;
          "Mod+Shift+0".move-column-to-workspace = 0;

          "Mod+Minus".set-column-width = "-10%";
          "Mod+Equal".set-column-width = "+10%";
          "Mod+Shift+Minus".set-window-height = "-10%";
          "Mod+Shift+Equal".set-window-height = "+10%";

          "Mod+V".toggle-window-floating = _: {};
          "Mod+Shift+V".switch-focus-between-floating-and-tiling = _: {};

          "Mod+D".switch-preset-column-width = _: {};
          "Mod+Shift+D".switch-preset-window-height = _: {};
          "Mod+Ctrl+D".reset-window-height = _: {};
          "Mod+F".maximize-column = _: {};
          "Mod+Shift+F".fullscreen-window = _: {};
          "Mod+C".center-column = _: {};

          "Print".spawn-sh = "${noctaliaExe} msg screenshot-region";
          "Ctrl+Print".spawn-sh = "${noctaliaExe} msg screenshot-fullscreen";
          "Alt+Print".spawn-sh = "${noctaliaExe} msg screenshot-window";

          "XF86AudioRaiseVolume".spawn-sh = "${noctaliaExe} msg volume-up 0.05";
          "XF86AudioLowerVolume".spawn-sh = "${noctaliaExe} msg volume-down 0.05";
          "XF86AudioMute".spawn-sh = "${noctaliaExe} msg volume-mute";
          "XF86AudioMicMute".spawn-sh = "${noctaliaExe} msg mic-mute";

          "XF86MonBrightnessUp".spawn-sh = "${noctaliaExe} msg brightness-up 0.05";
          "XF86MonBrightnessDown".spawn-sh = "${noctaliaExe} msg brightness-down 0.05";
        };
      };
    };
  in {
    packages.niri = pkgs.symlinkJoin {
      name = "niri-wrapped";
      paths = [niri-wrapped];
      passthru = (niri-wrapped.passthru or {}) // {unwrapped = niri-wrapped;};
      postBuild = ''
        rm $out/bin/niri-session
        cp -p ${niri-wrapped}/bin/niri-session $out/bin/niri-session
        patch $out/bin/niri-session < ${./systemd-no-import-env.patch}
      '';
    };
  };
}
