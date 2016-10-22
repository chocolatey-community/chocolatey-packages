$packageName = '{{PackageName}}'
$installerType = 'msi'
$url = '{{DownloadUrl}}'
$silentArgs = '/passive /norestart'
$validExitCodes = @(0)

Install-ChocolateyPackage $packageName $installerType `
  $silentArgs $url -validExitCodes $validExitCodes
