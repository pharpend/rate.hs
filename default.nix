{ stdenv
, pkgs ? (import <nixpkgs> {})
, haskellPackages ? pkgs.haskellngPackages }:

let
  env = haskellPackages.ghcWithPackages (p: with p; [
    pkgs.stdenv
    haskellPackages.cabal-install
    hlint

    snap
    snap-core
    snap-server
    snap-loader-static

    groundhog
    groundhog-postgresql
    groundhog-th

    resource-pool

    lens

    heist

    # maybe later:

    # rest-snap
    # aeson

    # snap-extras
    # snaplet-hslogger
  ]);
in

stdenv.mkDerivation rec {
    name = "rate.hs";
    src = ./src;
    version = "0.0.0.0";

    buildInputs = [ env ];

}

