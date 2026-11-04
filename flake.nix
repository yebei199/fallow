{
  description = "fallow, packaged from the official static Linux release";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs }:
    let
      system = "x86_64-linux";
      fallow = nixpkgs.legacyPackages.${system}.callPackage ./nix/package.nix { };
    in
    {
      packages.${system} = {
        inherit fallow;
        default = fallow;
      };
      apps.${system}.default = {
        type = "app";
        program = "${fallow}/bin/fallow";
      };
    };
}
