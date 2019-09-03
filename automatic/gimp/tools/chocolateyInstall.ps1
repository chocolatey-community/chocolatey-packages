$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://download.gimp.org/mirror/pub/gimp/v2.10/windows/gimp-2.10.12-setup.exe'
  softwareName   = 'GIMP'
  checksum       = '40bf733beb554e0a5f5ab5b82e75c035eefd715b00cc0eaf1cd57ba8a7e2ab6f'
  checksumType   = 'sha256'
  silentArgs     = "/VERYSILENT /NORESTART /RESTARTEXITCODE=3010 /SUPPRESSMSGBOXES /SP- /LOG=`"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).InnoInstall.log`""
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
