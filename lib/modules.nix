{ lib, ... }:
{
  mkSelectorModule =
    path: selectionOption:
    { config, ... }:
    {
      options = lib.setAttrByPath path {
        ${selectionOption.name} = lib.mkOption {
          type = (lib.getAttrFromPath path config).${lib.last path} |> builtins.attrNames |> lib.types.enum;

          inherit (selectionOption) default description example;
        };
      };

      config = lib.setAttrByPath (
        path
        ++ [
          (lib.last path)
          (lib.getAttrFromPath path config).${selectionOption.name}
        ]
      ) { enable = lib.mkDefault true; };
    };
}
