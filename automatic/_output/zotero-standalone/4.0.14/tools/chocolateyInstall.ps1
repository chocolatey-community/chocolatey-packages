$packageName = 'zotero-standalone' 
$installerType = 'EXE' 
$url = 'http://download.zotero.org/standalone/4.0.14/Zotero-4.0.14_setup.exe' # download url
$silentArgs = '/S' 
$validExitCodes = @(0) 

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" -validExitCodes $validExitCodes
