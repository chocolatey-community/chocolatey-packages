$packageName = 'zotero-standalone' 
$installerType = 'EXE' 
$url = '{{DownloadUrl}}' # download url
$silentArgs = '/S' 
$validExitCodes = @(0) 

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" -validExitCodes $validExitCodes
