{
  lib,
  stdenvNoCC,
  fetchurl,
}:

let
  # Written by .github/workflows/nix-update.yml.
  release = lib.importJSON ./release.json;
in
stdenvNoCC.mkDerivation {
  pname = "fallow";
  inherit (release) version;

  src = fetchurl {
    url = "https://github.com/fallow-rs/fallow/releases/download/v${release.version}/fallow-linux-x64-musl";
    inherit (release) hash;
  };

  dontUnpack = true;
  installPhase = "install -Dm755 $src $out/bin/fallow";

  meta = {
    description = "Static analysis for TypeScript and JavaScript codebases";
    homepage = "https://github.com/fallow-rs/fallow";
    license = lib.licenses.mit;
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
    mainProgram = "fallow";
    platforms = [ "x86_64-linux" ];
  };
}
