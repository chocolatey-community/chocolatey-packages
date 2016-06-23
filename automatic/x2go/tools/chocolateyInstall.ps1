$packageId		= '{{PackageName}}'
$packageName	= 'X2Go Client'
$installerType	= 'EXE'
$url			= '{{DownloadUrl}}'
$silentArgs		= '/S'

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url"
