$packageName = '{{PackageName}}'
$installerType = 'exe'
$url = '{{DownloadUrl}}'
$silentArgs = '/S'
$validExitCodes = @(0)

$PSScriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Definition

# Download and unzip the installer
Install-ChocolateyZipPackage 'clover-zipped-setup' $url $PSScriptRoot

# Get the path to the installer. Also takes into account that the installer
# .exe could be named differently in a future release.
$pathToInstaller = (Get-ChildItem -Path $PSScriptRoot -Filter '*.exe')[0].FullName

# Run the extracted installer
Install-ChocolateyInstallPackage $packageName $installerType $silentArgs $pathToInstaller -validExitCodes $validExitCodes

# No reason to keep the installer, also prevents from generating shim
Remove-Item $pathToInstaller
