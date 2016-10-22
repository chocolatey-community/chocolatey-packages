$packageName = '{{PackageName}}'
$version = '{{PackageVersion}}'
$installerType = 'exe'
$url = '{{DownloadUrl}}'
$silentArgs = '-install'
$validExitCodes = @(0)

#installer automatically overrides existing PPAPI installation
Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url"  -validExitCodes $validExitCodes
