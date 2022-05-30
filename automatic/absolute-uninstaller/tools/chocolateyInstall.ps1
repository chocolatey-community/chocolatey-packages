$ErrorActionPreference = 'STOP'

$packageArgs = @{
  packageName    = 'absolute-uninstaller'
  url            = 'https://download.glarysoft.com/ausetup.exe'
  fileType       = 'exe'
  softwareName   = 'Absolute Uninstaller*'
  checksum       = '5cb083f0befbb27d8e9f0cfc08defab33ae2397c0edd24e6292dcb256bd8bad7'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}
Install-ChocolateyPackage @packageArgs

# Remove MaiaGames
Remove-Item -Force -ea 0 "$Env:Public/Desktop/Maiagames.lnk"
Remove-Item -Force -Recurse -ea 0 "$Env:ProgramData/GlarySoft/Maiagames"
