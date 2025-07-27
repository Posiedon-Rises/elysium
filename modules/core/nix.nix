{ ... }:

{
  nixpkgs.config.allowUnfree = true;
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
      "pipe-operators"
    ];
    auto-optimise-store = true;

    substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
      "https://hyprland.cachix.org"
      "https://notashelf.cachix.org"
    ];

    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "notashelf.cachix.org-1:VTTBFNQWbfyLuRzgm2I7AWSDJdqAa11ytLXHBhrprZk="
    ];
  };
  nix.extraOptions = ''
    binary-caches-parallel-connections = 5
  '';

  nix.gc = {
    automatic = true;
    dates = "12:00";
  };

  nixpkgs.config.permittedInsecurePackages = [ "SDL_ttf-2.0.11" ];

  programs.nh = {
    enable = true;
    flake = "/etc/nixos";
  };

  # Just don't change unless absolutly necessary
  system.stateVersion = "24.11"; # Did you read the comment?
}
