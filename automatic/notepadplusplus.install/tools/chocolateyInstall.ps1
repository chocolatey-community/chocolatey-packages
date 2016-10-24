$ErrorActionPreference = 'Stop'

$packageName = 'notepadplusplus'
$url32       = 'https://notepad-plus-plus.org/repository/7.x/7.1/npp.7.1.Installer.exe'
$url64       = 'https://notepad-plus-plus.org/repository/7.x/7.1/npp.7.1.Installer.x64.exe'
$checksum32  = '0b4d6d08c07b946ec1d64fc806dd7622849914bf549620b86ad2eb7105c84887'
$checksum64  = '7ffbd579a0b608092aee3d5d58a24807a62cecbe10bf40cd3bb083f516ca1037'

$packageArgs = @{
  packageName            = $packageName
  fileType               = 'EXE'
  url                    = $url32
  url64bit               = $url64
  checksum               = $checksum32
  checksum64             = $checksum64
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  registryUninstallerKey = 'notepad\+\+'
}
Install-ChocolateyPackage @packageArgs

$installLocation = Get-AppInstallLocation $packageArgs.registryUninstallerKey
if ($installLocation)  {
    Write-Host "$packageName installed to '$installLocation'"
    #Register-Application "$installLocation\$packageName.exe"
    #Write-Host "$packageName registered as $packageName"
}
else { Write-Warning "Can't find $PackageName install location" }
