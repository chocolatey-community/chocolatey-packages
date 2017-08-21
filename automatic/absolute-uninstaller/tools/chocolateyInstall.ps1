$ErrorActionPreference = 'STOP'

$packageArgs = @{
  packageName    = 'absolute-uninstaller'
  url            = 'http://download.glarysoft.com/ausetup.exe'
  fileType       = 'exe'
  softwareName   = 'Absolute Uninstaller*'
  checksum       = '6822236a408fb665f57679eef58215c921abfced1bd997a79a455673d98ff67a'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}
Install-ChocolateyPackage @packageArgs

# Remove MaiaGames
rm -Force -ea 0 "$Env:Public/Desktop/Maiagames.lnk"
rm -Force -Recurse -ea 0 "$Env:ProgramData/GlarySoft/Maiagames"
