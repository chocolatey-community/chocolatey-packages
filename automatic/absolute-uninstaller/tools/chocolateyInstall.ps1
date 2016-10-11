$packageName = 'absolute-uninstaller'
$url = 'http://download.glarysoft.com/ausetup.exe'
$checksum = '1a9146ac0eaa94b6389625e743cc17406073f4217b3a46df3799dc834fe8119a'
$checksumType = 'sha256'

$packageArgs = @{
  packageName = $packageName
  fileType = 'exe'
  softwareName = 'Absolute Uninstaller*'

  checksum = $checksum
  checksumType = $checksumType
  url = $url

  silentArgs = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs

# Remove MaiaGames Desktop Link¨
$shortcut = "$env:PUBLIC/Desktop/Maiagames.lnk"
$programdata = "$env:ProgramData/GlarySoft/Maiagames"

If (Test-Path "$shortcut") { Remove-Item -Force "$shortcut"}
If (Test-Path "$programdata") { Remove-Item -Force -Recurse "$programdata"}
