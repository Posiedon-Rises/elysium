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
      "https://ocharles.cachix.org"
      "https://r-ryantm.cachix.org"
      "https://mpickering.cachix.org"
      "https://chessai.cachix.org"
      "https://hyprland.cachix.org"
    ];

    trusted-public-keys = [
      "ocharles.cachix.org-1:tZc7pKI8if0igUsr6QJD9GaM1pddllatd4W+8IQoH0I="
      "r-ryantm.cachix.org-1:gkUbLkouDAyvBdpBX0JOdIiD2/DP1ldF3Z3Y6Gqcc4c="
      "mpickering.cachix.org-1:COxPsDJqqrggZgvKG6JeH9baHPue8/pcpYkmcBPUbeg="
      "chessai.cachix.org-1:KWZ25BN1sJQ5PXT4bY/ye2KpaVXG2+tO8N76sxsp7YQ="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
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

  # Just don't change unless absolutly necessary
  system.stateVersion = "24.11"; # Did you read the comment?
}
