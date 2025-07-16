{ ... }:

{
  elysium = {
    desktops.desktops.niri.enable = true;

    development = {
      languages.nix.enable = true;
    };

    programs = {
      art.enable = true;
      internet.enable = true;
      office.enable = true;
      utilities.enable = true;
    };
  };
}
