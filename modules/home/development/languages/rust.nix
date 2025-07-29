{ config, lib, pkgs, ... }: 

let 
	cfg = config.elysium.development.languages.rust;
in {
	options.elysium.development.languages.rust = {
		enable = lib.mkEnableOption "Rust dev tooling";
		toolchain = lib.mkPackageOption pkgs "Fenix toolchain to use" { 
			default = [ "fenix" "complete" "toolchain" ];
		};
	};

	config = lib.mkIf cfg.enable {
		home.packages = [
			cfg.toolchain
		];
	};
}
