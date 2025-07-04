{
  stdenv,
  fetchFromGitHub,
  lib,
}:

stdenv.mkDerivation rec {
  pname = "mlxbf-bootctl";
  version = "1.1-6";

  src = fetchFromGitHub {
    owner = "Mellanox";
    repo = "mlxbf-bootctl";
    rev = "mlxbf-bootctl-${version}";
    hash = "sha256-F49ZZtty+NARXA/doAFLhsQn4XkPW6GWLXGy4waIaM0=";
  };

  installPhase = ''
    install -D mlxbf-bootctl $out/bin/mlxbf-bootctl
  '';

  meta = {
    description = "Control BlueField boot partitions";
    homepage = "https://github.com/Mellanox/mlxbf-bootctl";
    license = lib.licenses.bsd2;
    changelog = "https://github.com/Mellanox/mlxbf-bootctl/releases/tag/${pname}-${version}";
    # This package is supposed to only run on a BlueField. Thus aarch64-linux
    # is the only relevant platform.
    platforms = [ "aarch64-linux" ];
    maintainers = with lib.maintainers; [ nikstur ];
  };
}
