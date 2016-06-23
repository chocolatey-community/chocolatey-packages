$packageName = '{{PackageName}}'
$installerType = 'exe'
$version = '{{PackageVersion}}'
$url = "http://sourceforge.net/projects/qbittorrent/files/qbittorrent-win32/qbittorrent-${version}/qbittorrent_${version}_setup.exe/download"
$checksum = '{{Checksum}}'
$checksumType = 'SHA1'
$silentArgs = '/S'
$validExitCodes = @(0, 1223)

Install-ChocolateyPackage $packageName $installerType $silentArgs $url -validExitCodes $validExitCodes -checksum $checksum -checksumType $checksumType
