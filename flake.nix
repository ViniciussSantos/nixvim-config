{
  description = "Vini's portable Neovim, declared with nixvim";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      perSystem =
        { pkgs, system, ... }:
        let
          nvim = inputs.nixvim.legacyPackages.${system}.makeNixvim {
            imports = [ ./config ];
          };
        in
        {
          packages = {
            default = nvim;
            nvim = nvim;
          };

          apps.default = {
            type = "app";
            program = "${nvim}/bin/nvim";
          };
        };
    };
}
