{ lib, stdenv, vscode-utils, callPackage }:
let
  version = "1.42.0";
  rescript-editor-analysis = callPackage ./rescript-editor-analysis.nix { inherit version; };
  arch =
    if stdenv.isLinux then "linux"
    else if stdenv.isDarwin then "darwin"
    else throw "Unsupported system: ${stdenv.system}";
  analysisDir = "server/analysis_binaries/${arch}";
in
vscode-utils.buildVscodeMarketplaceExtension rec {
  mktplcRef = {
    name = "rescript-vscode";
    publisher = "chenglou92";
    inherit version;
    sha256 = "sha256-Po7zuppr8EHSfg2sDzkNn0KARncsiNVPoRsd25zc/xg=";
  };
  postPatch = ''
    rm -r ${analysisDir}
    ln -s ${rescript-editor-analysis}/bin ${analysisDir}
  '';

  meta = {
    description = "The official VSCode plugin for ReScript";
    homepage = "https://github.com/rescript-lang/rescript-vscode";
    maintainers = [ lib.maintainers.dlip lib.maintainers.jayesh-bhoot ];
    license = lib.licenses.mit;
  };
}
