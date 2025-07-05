{ lib, ... }:
{

  relativeToRoot = lib.path.append ../.;

  scanPaths =
    path:
    builtins.readDir path
    |> lib.attrsets.filterAttrs (
      name: type:
      (type == "directory") || ((name != "default.nix") && (lib.strings.hasSuffix ".nix" name))
    )
    |> builtins.attrNames
    |> builtins.map (f: "${path}/${f}");

  # TODO: fix
  # anyUserHasOption = optionPath:
  # let
  #   users = home-manager.users;
  # in
  #  lib.any (userCfg: lib.attrByPath optionPath false userCfg) (lib.attrValues users);

}
// lib.mergeAttrsList [
  (import ./options.nix { inherit lib; })
  (import ./modules.nix { inherit lib; })
]
