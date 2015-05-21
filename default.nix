{ pkgs ? (import <nixpkgs> {})
, haskellPackages ? pkgs.haskellPackages_ghc784 }:

haskellPackages.cabal.mkDerivation (self: {
    pname = "rate.hs";
    version = "0.0.0.0";

    src = ./.;

    isLibrary = false;
    isExecutable = true;

    buildDepends = with pkgs.haskellngPackages; [
      pkgs.stdenv
      haskellPackages.cabalInstall
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
    ];

    testDepends = with haskellPackages; [ ];

    meta = {
      homepage = "http://github.com/hamot/hamot";
      description = "Haskell Money Tracker application";
      license = self.stdenv.lib.licenses.gpl2;
      platforms = self.ghc.meta.platforms;
    };
})


