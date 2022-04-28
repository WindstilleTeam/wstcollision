{
  description = "Generic 2d editor for games";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.11";
    flake-utils.url = "github:numtide/flake-utils";

    clanlib.url = "gitlab:grumbel/clanlib-1.0";
    # clanlib.inputs.nixpkgs.follows = "nixpkgs";
    clanlib.inputs.flake-utils.follows = "flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, clanlib }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in rec {
        packages = flake-utils.lib.flattenTree {
          collisiontest = pkgs.stdenv.mkDerivation {
            pname = "collisiontest";
            version = "0.0.0";
            src = nixpkgs.lib.cleanSource ./.;
            installPhase = ''
              mkdir $out/bin
              cp -v main $out/bin/collisiontest
              wrapProgram $out/bin/collisiontest \
                --prefix LIBGL_DRIVERS_PATH ":" "${pkgs.mesa.drivers}/lib/dri" \
                --prefix LD_LIBRARY_PATH ":" "${pkgs.mesa.drivers}/lib"
            '';
            nativeBuildInputs = with pkgs; [
              makeWrapper
              pkgconfig
              scons
            ];
            buildInputs = [
              clanlib.defaultPackage.${system}
            ];
           };
        };
        defaultPackage = packages.collisiontest;
      });
}
