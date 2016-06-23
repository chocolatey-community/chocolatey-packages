$packageName	= '{{PackageName}}'
$installerType	= 'EXE'
$url			= '{{DownloadUrl}}'
$url64			= '{{DownloadUrlx64}}'
$silentArgs		= '/S' # NSIS package
$validExitCodes	= @(0)
$pwd			= "$(split-path -parent $MyInvocation.MyCommand.Definition)"

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" "$url64" -validExitCodes $validExitCodes
