$ErrorActionPreference = 'Stop'

$packageName = 'autohotkey.install'
$url32       = 'https://autohotkey.com/download/1.1/AutoHotkey112401_Install.exe'
$url64       = $url32
$checksum32  = '78ea671c3305465933a5d00f39da7e86c116a8a5a1849835196a27799ac29f8f'
$checksum64  = $checksum32

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
  registryUninstallerKey = $packageName
}
Install-ChocolateyPackage @packageArgs

$installLocation = Get-AppInstallLocation $packageArgs.registryUninstallerKey
if ($installLocation)  {
    Write-Host "$packageName installed to '$installLocation'"
}
else {
    Write-Warning "Can't find $PackageName install location"
}

