{ lib
, fetchFromGitHub
, buildPythonPackage
, pythonOlder
, pythonAtLeast
, pytestCheckHook
}:

buildPythonPackage rec {
  pname = "dacite";
  version = "1.7.0";
  format = "setuptools";

  disabled = pythonOlder "3.6";

  src = fetchFromGitHub {
    owner = "konradhalas";
    repo = pname;
    rev = "refs/tags/v${version}";
    sha256 = "sha256-+yWvlJcOmqDkHl3JZfPnIV3C4ieSo4FiBvoUZ0+J4N0=";
  };

  checkInputs = [
    pytestCheckHook
  ];

  disabledTests = lib.optionals (pythonAtLeast "3.10") [
    # https://github.com/konradhalas/dacite/issues/167
    "test_from_dict_with_union_and_wrong_data"
  ];

  pythonImportsCheck = [
    "dacite"
  ];

  meta = with lib; {
    description = "Python helper to create data classes from dictionaries";
    homepage = "https://github.com/konradhalas/dacite";
    license = licenses.mit;
    maintainers = with maintainers; [ fab ];
  };
}
