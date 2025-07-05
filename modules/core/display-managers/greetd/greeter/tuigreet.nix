{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg'' = config.elysium.display-managers;
  cfg' = cfg''.display-managers.greetd;
  cfg = cfg'.greeter.greeter.tuigreet;
in
{
  options.elysium.display-managers.display-managers.greetd.greeter.greeter.tuigreet.enable =
    lib.mkEnableOption "tuigreet";

  config = lib.mkIf (cfg''.enable && cfg'.enable && cfg.enable) {
    environment.systemPackages = [ pkgs.greetd.tuigreet ];
    services.greetd.settings.default_session.command = builtins.concatStringsSep " " [
      (lib.getExe pkgs.greetd.tuigreet)
      "--time"
      "--user-menu"
      "--remember"
      "--remember-user-session"
      "--theme='border=cyan;text=blue;prompt=blue;time=cyan;action=blue;button=yellow;container=black;input=magenta'"
      "--power-shutdown 'systemctl poweroff'"
      "--power-reboot 'systemctl reboot'"
    ];
  };
}
