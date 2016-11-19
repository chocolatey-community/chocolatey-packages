# This file is just to simplify importing of extensions for use in AU update scripts

$modules = ls "$PSSCriptRoot/*.psm1" -Recurse -Exclude "extensions.psm1"

foreach ($module in $modules) {
  import-module $module.FullName
}