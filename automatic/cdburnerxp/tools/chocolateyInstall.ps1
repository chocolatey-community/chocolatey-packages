$packageName = '{{PackageName}}'
$installerType = 'MSI'
$32BitUrl  = '{{DownloadUrl}}'
$64BitUrl  = '{{DownloadUrlx64}}'
$silentArgs = '/quiet'
$validExitCodes = @(0)

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$32BitUrl" "$64BitUrl" -validExitCodes $validExitCodes