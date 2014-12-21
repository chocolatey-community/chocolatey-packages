$tools="$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
Start-ChocolateyProcessAsAdmin "certutil -addstore 'TrustedPublisher' '$tools\sysprogs.cer'"

$packageName = '{{PackageName}}'
$fileType = 'exe'
$silentArgs = '/UNATTENDED'
# {\{DownloadUrlx64}\} gets “misused” here as 32-bit download link due to limitations of Ketarin/chocopkgup
$url = '{{DownloadUrlx64}}'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url
