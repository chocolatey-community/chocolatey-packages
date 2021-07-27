$ErrorActionPreference = 'STOP'

$packageArgs = @{
  packageName    = 'absolute-uninstaller'
  url            = 'https://download.glarysoft.com/ausetup.exe'
  fileType       = 'exe'
  softwareName   = 'Absolute Uninstaller*'
  checksum       = 'ad26429f21f70ac4edba908bd0bca0f5b63e6d092c40501da695a78edf80ee23'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}
Install-ChocolateyPackage @packageArgs

# Remove MaiaGames
Remove-Item -Force -ea 0 "$Env:Public/Desktop/Maiagames.lnk"
Remove-Item -Force -Recurse -ea 0 "$Env:ProgramData/GlarySoft/Maiagames"
