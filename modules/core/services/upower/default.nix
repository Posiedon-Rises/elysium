{ config, lib, ... }:

let
  cfg = config.elysium.services.upower;
in
{
	options.elysium.services.upower.enable = lib.mkEnableOption "Upower" // {
		default = config.hostSpec.isDesktop;
	};

	config = lib.mkIf cfg.enable {
		services.upower = {
			enable = true;

			criticalPowerAction = "PowerOff";
		};
	};
}
