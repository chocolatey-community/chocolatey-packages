$ErrorActionPreference = 'STOP'

$packageArgs = @{
  packageName    = 'absolute-uninstaller'
  url            = 'https://download.glarysoft.com/ausetup.exe'
  fileType       = 'exe'
  softwareName   = 'Absolute Uninstaller*'
  checksum       = 'd35e55f0da927ce4c5866d876dded18d3194d0136ff451447971b868c7628be2'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}
Install-ChocolateyPackage @packageArgs

# Remove MaiaGames
Remove-Item -Force -ea 0 "$Env:Public/Desktop/Maiagames.lnk"
Remove-Item -Force -Recurse -ea 0 "$Env:ProgramData/GlarySoft/Maiagames"
