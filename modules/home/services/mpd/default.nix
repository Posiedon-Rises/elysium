{ config, lib, ... }:

let
	cfg = config.elysium.services.mpd;
in {
	options.elysium.services.mpd.enable = lib.mkEnableOption "MPD music" // {
		default = config.hostSpec.isDesktop;
	};

	config = lib.mkIf cfg.enable {
		services.mpd.enable = true;
		services.mpd-mpris.enable = true;
	};
}
