{ config, lib, ... }:

let
	cfg' = config.elysium.shells.programs;
	cfg = cfg'.rmpc;
in {
	options.elysium.shells.programs.rmpc.enable = lib.mkEnableOption "rmpc" // {
		default = cfg'.enableFun;
	};

	config = lib.mkIf cfg.enable {
		elysium.services.mpd.enable = lib.mkDefault true;

		programs.rmpc.enable = true;
	};
}
