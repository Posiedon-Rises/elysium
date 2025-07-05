{ ... }:

{
  # Nix
  programs = {
    nixfmt.enable = true;
    deadnix.enable = true;
  };
  # yaml
  programs.yamlfmt.enable = true;
}
