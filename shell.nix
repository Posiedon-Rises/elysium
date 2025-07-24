{ pkgs }:
pkgs.mkShell {
  nativeBuildInputs = builtins.attrValues {
    inherit (pkgs)
      nh
      just
      hello
      ;
  };
}
