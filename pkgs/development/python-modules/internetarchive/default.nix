{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  pytestCheckHook,
  requests,
  jsonpatch,
  schema,
  responses,
  setuptools,
  tqdm,
  urllib3,
  pythonOlder,
  importlib-metadata,
}:

buildPythonPackage rec {
  pname = "internetarchive";
  version = "5.3.0";
  pyproject = true;

  disabled = pythonOlder "3.9";

  src = fetchFromGitHub {
    owner = "jjjake";
    repo = "internetarchive";
    tag = "v${version}";
    hash = "sha256-1DJ4ZPL1Px1BKP9RHY/evoIwLzxG0aQNq9gteBi4RZs=";
  };

  build-system = [ setuptools ];

  dependencies = [
    tqdm
    requests
    jsonpatch
    schema
    urllib3
  ] ++ lib.optionals (pythonOlder "3.10") [ importlib-metadata ];

  nativeCheckInputs = [
    responses
    pytestCheckHook
  ];

  disabledTests = [
    # Tests require network access
    "test_get_item_with_kwargs"
    "test_upload"
    "test_upload_metadata"
    "test_upload_queue_derive"
    "test_upload_validate_identifie"
    "test_upload_validate_identifier"
  ];

  disabledTestPaths = [
    # Tests require network access
    "tests/cli/test_ia.py"
    "tests/cli/test_ia_download.py"
  ];

  pythonImportsCheck = [ "internetarchive" ];

  meta = {
    description = "Python and Command-Line Interface to Archive.org";
    homepage = "https://github.com/jjjake/internetarchive";
    changelog = "https://github.com/jjjake/internetarchive/blob/${src.tag}/HISTORY.rst";
    license = lib.licenses.agpl3Plus;
    maintainers = with lib.maintainers; [ pyrox0 ];
    mainProgram = "ia";
  };
}
