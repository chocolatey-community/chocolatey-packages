$packageName	= 'KeePass-Classic'
$installerType	= 'EXE'
$url			= '{{DownloadUrl}}'
$silentArgs		= '/VERYSILENT'
$validExitCodes	= @(0)
$pwd			= "$(split-path -parent $MyInvocation.MyCommand.Definition)"

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" -validExitCodes $validExitCodes
