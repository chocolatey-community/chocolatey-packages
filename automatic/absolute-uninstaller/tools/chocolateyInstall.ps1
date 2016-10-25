$ErrorActionPreference = 'STOP'

$packageArgs = @{
  packageName    = 'absolute-uninstaller'
  url            = 'http://download.glarysoft.com/ausetup.exe'
  fileType       = 'exe'
  softwareName   = 'Absolute Uninstaller*'
  checksum       = '1a9146ac0eaa94b6389625e743cc17406073f4217b3a46df3799dc834fe8119a'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}
Install-ChocolateyPackage @packageArgs

# Remove MaiaGames
rm -Force -ea 0 "$Env:Public/Desktop/Maiagames.lnk"
rm -Force -Recurse -ea 0 "$Env:ProgramData/GlarySoft/Maiagames"
