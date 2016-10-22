$ErrorActionPreference = 'Stop'

$packageName = 'autohotkey.install'
$url32       = 'https://autohotkey.com/download/1.1/AutoHotkey_1.1.24.02_setup.exe'
$url64       = $url32
$checksum32  = '1dc79c7157e9a98c807beeb3fb1961874142e0f41a8f71b80007935a4ae747ba'
$checksum64  = $checksum32

$silent = '/S'
if(Get-ProcessorBits 64) { $silent += ' /x64' }

$packageArgs = @{
  packageName            = $packageName
  fileType               = 'EXE'
  url                    = $url32
  url64bit               = $url64
  checksum               = $checksum32
  checksum64             = $checksum64
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = $silent
  validExitCodes         = @(0)
  registryUninstallerKey = 'autohotkey'
}
Install-ChocolateyPackage @packageArgs

$installLocation = Get-AppInstallLocation $packageArgs.registryUninstallerKey
if ($installLocation)  {
    Write-Host "$packageName installed to '$installLocation'"
}
else {
    Write-Warning "Can't find $PackageName install location"
}

