$packageName = '{{PackageName}}'
$installerType = 'exe'
$url = '{{DownloadUrl}}'
$silentArgs = '/S'
$validExitCodes = @(0)

Install-ChocolateyInstallPackage $packageName $installerType $silentArgs $url -validExitCodes $validExitCodes
