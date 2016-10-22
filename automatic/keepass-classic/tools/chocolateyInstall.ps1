$packageName = 'keepass-classic'
$installerType = 'exe'
$url = 'http://sourceforge.net/projects/keepass/files/KeePass 1.x/{{PackageVersion}}/KeePass-{{PackageVersion}}-Setup.exe/download'
$silentArgs = '/VERYSILENT'
$validExitCodes = @(0)
$pwd = "$(split-path -parent $MyInvocation.MyCommand.Definition)"

Install-ChocolateyPackage "$packageName" "$installerType" `
  "$silentArgs" "$url" -validExitCodes $validExitCodes
