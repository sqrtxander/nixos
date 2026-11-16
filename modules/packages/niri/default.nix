{ inputs, moduleWithSystem, ...}: {
  flake.nixosModules.niri = moduleWithSystem ({self', pkgs, ...}: {
    programs.niri = {
      enable = true;
      package = self'.packages.niri;
    };
    systemd.user.services.niri.enableDefaultPath = false;
  });
  perSystem = { pkgs, lib, self', ...}: let
    niri-wrapped = inputs.wrappers.wrappers.niri.wrap {
      inherit pkgs;
      settings = {
        prefer-no-csd = _: { };

        spawn-at-startup = [
          (lib.getExe self'.packages.noctalia)
        ];

        input = {
          keyboard = {
            xkb.options = "compose:ralt";
            numlock =  _: { };
          };
          touchpad = {
            tap = _: { };
            natural-scroll =  _: { };
          };
          warp-mouse-to-focus =  _: { };
        };
        layout = {
          gaps = 5;
        };
        gestures.hot-corners.off = _: {};
        screenshot-path = "~/pictures/screenshots/%Y-%m-%d-%H-%M-%S.png";
        binds = {
          "Mod+Return".spawn-sh = lib.getExe self'.packages.foot;
          "Mod+B".spawn-sh = lib.getExe pkgs.librewolf;
          "Mod+Q".close-window = _: { };
          "Mod+R".spawn-sh = "${lib.getExe self'.packages.noctalia} msg panel-toggle launcher";
          "Mod+O".toggle-overview = _: {};

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

          "Mod+V".toggle-window-floating = _:{};
          "Mod+Shift+V".switch-focus-between-floating-and-tiling = _:{};

          "Mod+D".switch-preset-column-width = _: {};
          "Mod+Shift+D".switch-preset-window-height = _: {};
          "Mod+Ctrl+D".reset-window-height = _: {};
          "Mod+F".maximize-column = _: {};
          "Mod+Shift+F".fullscreen-window = _: {};
          "Mod+C".center-column = _: {};

          "Print".screenshot = _: {};
          "Ctrl+Print".screenshot-screen = _: {};
          "Alt+Print".screenshot-window = _: {};

          "XF86AudioRaiseVolume".spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05+ -l 1.0";
          "XF86AudioLowerVolume".spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05-";
          "XF86AudioMute".spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          "XF86AudioMicMute".spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";

          "XF86MonBrightnessUp".spawn-sh = "brightnessctl --class=backlight set +10%";
          "XF86MonBrightnessDown".spawn-sh =  "brightnessctl --class=backlight set 10%-";
        };
      };
    };
    in {
      packages.niri = pkgs.symlinkJoin {
        name = "niri-wrapped";
        paths = [ niri-wrapped ];
        passthru = (niri-wrapped.passthru or { }) // {unwrapped = niri-wrapped; };
        postBuild = ''
          rm $out/bin/niri-session
          cp -p ${niri-wrapped}/bin/niri-session $out/bin/niri-session
          patch $out/bin/niri-session < ${./systemd-no-import-env.patch}
        '';
      };
    };
}
