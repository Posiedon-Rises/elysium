{ lib, ... }:

{
  imports = [ (lib.elysium.relativeToRoot "modules/home") ];
  
  elysium = {
  	development.enable = true;

    programs = {
      art.enable = true;
      internet.enable = true;
      office.enable = true;
      utilities.enable = true;
    };
  };
}

