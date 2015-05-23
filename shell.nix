{ pkgs ? (import <nixpkgs> {})
, haskellPackages ? pkgs.haskellngPackages }:

(import ./default.nix) {
  stdenv = pkgs.stdenv;
  pkgs = pkgs;
  haskellPackages = haskellPackages;
}
