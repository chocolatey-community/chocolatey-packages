$tools="$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
Start-ChocolateyProcessAsAdmin "certutil -addstore 'TrustedPublisher' '$tools\sysprogs.cer'"

$packageName = '{{PackageName}}'
$fileType = 'exe'
$silentArgs = '/UNATTENDED'
$url = '{{DownloadUrl}}'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url