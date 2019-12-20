$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://download.gimp.org/mirror/pub/gimp/v2.10/windows/gimp-2.10.14-setup.exe'
  softwareName   = 'GIMP'
  checksum       = '6de7f8722a0601e821c6cbfe3fc8b5055fb32d59d2b64fbdbd19f7dcf5a4b8e9'
  checksumType   = 'sha256'
  silentArgs     = "/VERYSILENT /NORESTART /RESTARTEXITCODE=3010 /SUPPRESSMSGBOXES /SP- /LOG=`"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).InnoInstall.log`""
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
