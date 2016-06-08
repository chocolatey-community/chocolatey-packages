$packageName	= '{{PackageName}}'
$installerType	= 'EXE'
$url			= '{{DownloadUrl}}'
$silentArgs		= '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' # Inno Setup package
$validExitCodes	= @(0)

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" -validExitCodes $validExitCodes
