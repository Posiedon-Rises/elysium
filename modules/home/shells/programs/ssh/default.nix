{ config, lib, ... }:

let
  cfg = config.elysium.shells.programs.ssh;
in
{
  options.elysium.shells.programs.ssh.enable = lib.mkEnableOption "SSH" // {
    default = true;
  };

  config = lib.mkIf cfg.enable {
    services.ssh-agent.enable = true;

    elysium.shells.shellAliases = {
      # Key add identity
      kai = "ssh-add ~/.ssh/id_ed25519";
      # Key add git
      kag = "ssh-add ~/.ssh/git_ed25519";
      # Key add all
      kaa = "kai && kag";
    };
  };
}
