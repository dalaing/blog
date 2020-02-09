{ nixpkgs ? import <nixpkgs> {} }:
let
  inherit (nixpkgs) pkgs;
  haskellPackages = nixpkgs.haskellPackages.override {
    overrides = self: super: {
      blog-generator = self.callCabal2nix "blog-generator" ./generator {};
    };
  };

  mytexlive = (pkgs.texlive.combine {
    inherit (pkgs.texlive)
    prftree
    scheme-basic
    collection-latexrecommended;
  }); 

  content = nixpkgs.stdenv.mkDerivation {
    name = "blog-content";
    src = ./content;

    buildPhase = ''
      export LANG=en_US.UTF-8
      export LOCALE_ARCHIVE=/run/current-system/sw/lib/locale/locale-archive
      site build
    '';

    installPhase = ''
      mkdir -p $out
      cp -r _site/* $out/
      echo "dlaing.org" > $out/CNAME
    '';

    phases = ["unpackPhase" "buildPhase" "installPhase"];

    buildInputs = [haskellPackages.blog-generator mytexlive pkgs.imagemagick pkgs.ghostscript pkgs.glibcLocales];
  };
in
  content
