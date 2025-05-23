{
  rustPlatform,
  fetchFromGitHub,
  lib,
}:

rustPlatform.buildRustPackage rec {
  pname = "pipes-rs";
  version = "1.6.3";

  src = fetchFromGitHub {
    owner = "lhvy";
    repo = pname;
    tag = "v${version}";
    sha256 = "sha256-NrBmkA7sV1RhfG9KEqQNMR5s0l2u66b7KK0toDjQIps=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-0up9S3+NjBV8zsvsyVANvITisMSBXsab6jFwt19gnQk=";

  doInstallCheck = true;

  installCheckPhase = ''
    if [[ "$("$out/bin/${pname}" --version)" == "${pname} ${version}" ]]; then
      echo '${pname} smoke check passed'
    else
      echo '${pname} smoke check failed'
      return 1
    fi
  '';

  meta = with lib; {
    description = "Over-engineered rewrite of pipes.sh in Rust";
    mainProgram = "pipes-rs";
    homepage = "https://github.com/lhvy/pipes-rs";
    license = licenses.blueOak100;
    maintainers = [ maintainers.vanilla ];
  };
}
