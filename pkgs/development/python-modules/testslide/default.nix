{ lib
, buildPythonPackage
, fetchFromGitHub
, pythonOlder
, psutil
, pygments
, setuptools
, typeguard
, coverage
, coveralls
, pytestCheckHook
, pytest
}:

buildPythonPackage rec {
  pname = "TestSlide";
  version = "2.7.1";
  format = "setuptools";
  disabled = pythonOlder "3.7";

  src = fetchFromGitHub {
    owner = "facebook";
    repo = pname;
    rev = "refs/tags/${version}";
    hash = "sha256-M/qUhzbQzm3D6P2aM97z1llghqyi+XAZRZjyY1l+Wv4=";
  };

  nativeBuildInputs = [
    setuptools
  ];

  propagatedBuildInputs = [
    psutil
    pygments
    typeguard
  ];

  nativeCheckInputs = [
    coverage
    coveralls
    pytest
  ];

  pythonImportsCheck = [
    "testslide"
  ];

  checkPhase = ''
    pytest tests/*_unittest.py tests/*_testslide.py
  '';

  meta = with lib; {
    description = "A test framework for Python that makes mocking and iterating over code with tests a breeze";
    homepage = "https://github.com/facebook/TestSlide";
    changelog = "https://github.com/facebook/TestSlide/releases/tag/${version}";
    license = licenses.mit;
  };
}
