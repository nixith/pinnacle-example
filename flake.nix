{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    pinnacle.url = "github:nixith/pinnacle"; # should be url once uploaded
  };

  outputs = { self, nixpkgs, flake-utils, pinnacle }:
    flake-utils.lib.eachSystem [ "x86_64-linux" "aarch64-linux" ] (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        pinnacleLib = pinnacle.lib.${system};
      in {
        packages = {
          rustExample = pinnacleLib.pinnacleWithRust { src = ./rust; };
          luaExample = pinnacleLib.pinnacleWithLua {
            src = ./lua;
            entrypoint = "default_config.lua";
          };
        };
      });
}
