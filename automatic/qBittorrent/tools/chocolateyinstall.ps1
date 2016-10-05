$packageName = '{{PackageName}}'
$installerType = 'exe'
$version = '{{PackageVersion}}'
$url = '{{DownloadUrl}}'
$checksum = '{{Checksum}}'
$checksumType = 'SHA1'
$silentArgs = '/S'
$validExitCodes = @(0, 1223)

Install-ChocolateyPackage $packageName $installerType $silentArgs $url -validExitCodes $validExitCodes -checksum $checksum -checksumType $checksumType
