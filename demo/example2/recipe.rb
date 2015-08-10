class PythonPytrac < FPM::Cookery::PythonRecipe
  homepage      "https://github.com/Jimdo/pytrac"
  name          "pytrac"
  maintainer    "Daniel Bonkowski <bonko@jimdo.com>"
  build_depends ["python-setuptools"]
  depends       ["python"]
  version       "0.4"
end
