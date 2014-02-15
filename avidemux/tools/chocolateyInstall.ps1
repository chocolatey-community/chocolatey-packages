$packageName = '{{PackageName}}'
$fileType = 'exe'
$silentArgs = '/S'
$url = '{{DownloadUrl}}'
$url64bit = '{{DownloadUrlx64}}'
$validExitCodes = @(0,1223)

Install-ChocolateyPackage $packageName $fileType $silentArgs $url $url64bit -validExitCodes $validExitCodes