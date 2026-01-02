$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'freeciv'
  fileType       = 'exe'
  softwareName   = 'Freeciv*'

  checksum       = '4fca298ff3a8130e635ba28edec7183593437c946b00b38d4b2ab71c7c1afd65'
  checksumType   = 'sha256'
  url            = 'https://files.freeciv.org/packages/windows/Freeciv-3.2.2-msys2-win64-10-gtk3.22-setup.exe'

  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
