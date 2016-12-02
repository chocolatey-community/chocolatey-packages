Import-Module "D:\ChocoInstall\helpers\chocolateyInstaller.psm1"
Import-Module "$PSScriptRoot\..\..\..\extensions\extensions.psm1"

$packageName = 'qBittorrent'
$fosshubUrl = 'https://www.fosshub.com/qBittorrent.html/qbittorrent_3.3.7_setup.exe'
$checksum = '49ae9a0adfc3272bec38822c528f732d9495b79a2a7ca934f8c6635237b15d07'
$checksumType = 'sha256'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  softwareName   = 'qBittorrent*'

  checksum       = $checksum
  checksumType   = $checksumType
  url            = $fosshubUrl

  silentArgs     = '/S'
  validExitCodes = @(0, 1223)
}

Install-ChocolateyFosshub @packageArgs
