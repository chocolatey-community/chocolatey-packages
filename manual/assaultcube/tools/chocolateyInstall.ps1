$ErrorActionPreference = 'Stop'

$toolsPath   = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName            = 'assaultcube'
  fileType               = 'exe'
  url                    = 'https://github.com/assaultcube/AC/releases/download/v1.2.0.2/AssaultCube_v1.2.0.2.exe'
  checksum               = 'f048f6f046b4954dfd9c3e41a6b48b94167f8f93847dbf2a7820fdef4b85ea7e'
  checksumType           = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'assaultcube*'
}
Install-ChocolateyPackage @packageArgs

$packageName = $packageArgs.packageName
$installLocation = Get-AppInstallLocation $packageName
if ($installLocation)  {
    Write-Host "$packageName installed to '$installLocation'"
}
else { Write-Warning "Can't find $PackageName install location" }

