{
  lib,
  fetchFromGitHub,
  buildDunePackage,
  cudf,
}:

buildDunePackage rec {
  pname = "mccs";
  version = "1.1+19";

  src = fetchFromGitHub {
    owner = "AltGr";
    repo = "ocaml-mccs";
    tag = version;
    hash = "sha256-xvcqPXyzVGXXFYRVdFPaCfieFEguWffWVB04ImEuPvQ=";
  };

  propagatedBuildInputs = [
    cudf
  ];

  doCheck = true;

  meta = with lib; {
    description = "Library providing a multi criteria CUDF solver, part of MANCOOSI project";
    downloadPage = "https://github.com/AltGr/ocaml-mccs";
    homepage = "https://www.i3s.unice.fr/~cpjm/misc/";
    license = with licenses; [
      lgpl21
      gpl3
    ];
    maintainers = [ ];
  };
}
