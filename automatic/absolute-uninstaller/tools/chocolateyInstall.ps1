$packageName = 'absolute-uninstaller'
$url = 'http://download.glarysoft.com/ausetup.exe'
$checksum = '1a9146ac0eaa94b6389625e743cc17406073f4217b3a46df3799dc834fe8119a'
$checksumType = 'sha256'

$packageArgs = @{
  packageName = $packageName
  fileType = 'exe'
  softwareName = 'Absolute Uninstaller'

  checksum = $checksum
  checksumType = $checksumType
  url = $url

  silentArgs = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
