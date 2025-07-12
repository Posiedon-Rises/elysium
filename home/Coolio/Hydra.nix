{ lib, ... }:

{  
  elysium = {
    desktops.desktops.niri.enable = true;
    programs = {
      art.enable = true;
      internet.enable = true;
      office.enable = true;
      utilities.enable = true;
    };
  };
}

