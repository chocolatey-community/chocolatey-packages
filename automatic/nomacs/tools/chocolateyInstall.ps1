$packageName = '{{PackageName}}'
$fileType = 'exe'
$url = '{{DownloadUrl}}'
$url64bit = $url

$PSScriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Definition
$pathToInstallScript = Join-Path $PSScriptRoot 'install-script.js'
$silentArgs = "--script `"$pathToInstallScript`""

Install-ChocolateyPackage $packageName $fileType $silentArgs $url $url64bit
