# This file is just to simplify importing of extensions for use in Chocolatey AU update scripts

$modules = Get-ChildItem "$PSScriptRoot/*.psm1" -Recurse -Exclude "extensions.psm1"

foreach ($module in $modules) {
  Import-Module $module.FullName
}
