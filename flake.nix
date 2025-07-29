{
  description = "Elysium";

  outputs =
    {
      self,
      nixpkgs,
      ...
    }@inputs:
    let
      inherit (self) outputs;

      forAllSystems = nixpkgs.lib.genAttrs [
        "x86_64-linux"
        #"aarch64-linux"
      ];

      lib = nixpkgs.lib.extend (self: super: { elysium = import ./lib { inherit (nixpkgs) lib; }; });

      vauxhall = import ./vauxhall.nix;
    in
    {
      nixosConfigurations =
        ./hosts/nixos
        |> builtins.readDir
        |> builtins.attrNames
        |> map (host: {
          name = host;
          value = nixpkgs.lib.nixosSystem {
            specialArgs = {
              inherit
                inputs
                outputs
                lib
                vauxhall
                ;
            };
            modules = [
              ./hosts/nixos/${host}
              ./modules/core
              ./modules/host-spec.nix
            ];
          };
        })
        |> builtins.listToAttrs;

      formatter = forAllSystems (
        system:
        system
        |> (s: import nixpkgs { inherit system; })
        |> (pkgs: inputs.treefmt-nix.lib.mkWrapper pkgs ./treefmt.nix)
      );

      devShell = forAllSystems (
        system:
        import ./shell.nix {
          pkgs = nixpkgs.legacyPackages.${system};
        }
      );
    };

  inputs = {

    nixpkgs.url = "nixpkgs/nixos-unstable";

    master.url = "nixpkgs/master";

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    activate-linux = {
      url = "github:MrGlockenspiel/activate-linux";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "sops-nix/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.home-manager.follows = "home-manager";
    };

    tagstudio = {
      url = "github:TagStudioDev/TagStudio/";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    fenix = {
      url = "fenix/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
