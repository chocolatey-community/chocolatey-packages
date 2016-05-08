$PSScriptRoot = Split-Path -parent $MyInvocation.MyCommand.Definition
Import-Module (Join-Path $PSScriptRoot 'functions.ps1')

$packageName = '{{PackageName}}'
$fileType = 'exe'
$silentArgs = '/S'
$url = 'https://sourceforge.net/projects/maxima/files/Maxima-Windows/{{PackageVersion}}-Windows/maxima-clisp-sbcl-{{PackageVersion}}.exe/download'
$url64 = 'https://sourceforge.net/projects/maxima/files/Maxima-Windows/{{PackageVersion}}-Windows/maxima-sbcl-{{PackageVersion}}-win64.exe/download'
$version = '{{PackageVersion}}'
$installedVersion = (Get-InstallProperties).DisplayVersion

if ($version -eq $installedVersion) {
  Write-Output "Maxima v$version is already installed. No need to install again."
} else {
  Install-ChocolateyPackage $packageName $fileType $silentArgs $url $url64
}
