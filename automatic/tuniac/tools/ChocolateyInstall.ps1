$packageName = '{{PackageName}}'
$installerType = 'EXE'
$url = '{{DownloadUrl}}'
$url64 = '{{DownloadUrlx64}}'
$silentArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' # Inno Setup Package
$validExitCodes = @(0)

Install-ChocolateyPackage $packageName $installerType $silentArgs $url $url64 -validExitCodes $validExitCodes
