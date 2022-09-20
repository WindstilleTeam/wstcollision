{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.05";
    flake-utils.url = "github:numtide/flake-utils";

    clanlib.url = "github:grumbel/clanlib-1.0";
    # clanlib.inputs.nixpkgs.follows = "nixpkgs";
    clanlib.inputs.flake-utils.follows = "flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, clanlib }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        packages = rec {
          default = wstcollision;

          wstcollision = pkgs.stdenv.mkDerivation {
            pname = "wstcollision";
            version = "0.0.0";
            src = nixpkgs.lib.cleanSource ./.;
            postFixup = ''
              wrapProgram $out/bin/wstcollision \
                --prefix LIBGL_DRIVERS_PATH ":" "${pkgs.mesa.drivers}/lib/dri" \
                --prefix LD_LIBRARY_PATH ":" "${pkgs.mesa.drivers}/lib"
            '';
            nativeBuildInputs = with pkgs; [
              makeWrapper
              pkgconfig
              cmake
            ];
            buildInputs = [
              clanlib.packages.${system}.default
            ];
           };
        };
      }
    );
}
