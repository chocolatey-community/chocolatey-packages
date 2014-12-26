$packageName = '{{PackageName}}'
$installerType = 'EXE'
$32BitUrl  = '{{DownloadUrl}}'
$64BitUrl  = '{{DownloadUrlx64}}'
$silentArgs = '/S'
$validExitCodes = @(0)

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$32BitUrl" "$64BitUrl" -validExitCodes $validExitCodes