$packageName = '{{PackageName}}' 
$installerType = 'msi' 
# {\{DownloadUrlx64}\} gets “misused” here as 32-bit download link due to limitations of Ketarin/chocopkgup
$url = '{{DownloadUrlx64}}'
$silentArgs = '/passive /norestart' 
$validExitCodes = @(0) 


Install-ChocolateyPackage $packageName $installerType $silentArgs $url -validExitCodes $validExitCodes
