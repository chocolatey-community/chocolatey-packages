$ErrorActionPreference = 'Stop';

[array]$key = Get-UninstallRegistryKey -SoftwareName "Visual Studio"

if ($key.UninstallString) {
$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = 'wixtoolset-visualstudio2017extension'
  fileType       = 'vsix'
  VsixUrl        = "file://$toolsPath/Votive2017.vsix"
}

Install-ChocolateyVsixPackage @packageArgs
} else {
Write-Warning "Visual Studio not found installed on the system. This package will not be installed."
}
