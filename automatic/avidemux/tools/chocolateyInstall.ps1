$packageName = '{{PackageName}}'
$fileType = 'exe'
$silentArgs = '/S'
# {\{DownloadUrlx64}\} gets “misused” here as hashtable for the download links
# due to limitations of Ketarin/chocopkgup
$urlsHashTable = {{DownloadUrlx64}}
$url = $urlsHashTable.url
$url64bit = $urlsHashTable.url64
$validExitCodes = @(0,1223)

Install-ChocolateyPackage $packageName $fileType $silentArgs `
  $url $url64bit -validExitCodes $validExitCodes
