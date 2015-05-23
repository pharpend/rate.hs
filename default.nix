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

    snaplet-persistent

    persistent
    persistent-postgresql
    persistent-sqlite

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

    # meta = {
    #   homepage = "http://github.com/hamot/hamot";
    #   description = "Haskell Money Tracker application";
    #   license = self.stdenv.lib.licenses.gpl2;
    #   platforms = self.ghc.meta.platforms;
    # };
}

