$ErrorActionPreference = 'STOP'

$packageArgs = @{
  packageName    = 'absolute-uninstaller'
  url            = 'https://download.glarysoft.com/ausetup.exe'
  fileType       = 'exe'
  softwareName   = 'Absolute Uninstaller*'
  checksum       = '9c0f8019f0f81a62a5e404c169c61bd52e495d8699b830c3132469ae14e078af'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}
Install-ChocolateyPackage @packageArgs

# Remove MaiaGames
Remove-Item -Force -ea 0 "$Env:Public/Desktop/Maiagames.lnk"
Remove-Item -Force -Recurse -ea 0 "$Env:ProgramData/GlarySoft/Maiagames"
