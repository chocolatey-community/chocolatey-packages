$PSScriptRoot = Split-Path -parent $MyInvocation.MyCommand.Definition
Import-Module (Join-Path $PSScriptRoot 'functions.ps1')

$uninstallerPath = (Get-InstallProperties).UninstallString

if ($uninstallerPath -and (Test-Path $uninstallerPath)) {
  Uninstall-ChocolateyPackage '{{PackageName}}' 'exe' '/S' $uninstallerPath
}
