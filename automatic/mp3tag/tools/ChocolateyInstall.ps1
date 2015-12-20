$packageName = '{{PackageName}}'
$fileType = 'exe'
$version = '{{PackageVersion}}'
$silentArgs = '/S'
$url = '{{DownloadUrl}}'
$PSScriptRoot = Split-Path -parent $MyInvocation.MyCommand.Definition

$installerPath = Join-Path $PSScriptRoot "${packageName}.exe"
$iniFile = Join-Path $PSScriptRoot 'Mp3tagSetup.ini'

# Automatic language selection
$iniContent = Get-Content $iniFile
$LCID = (Get-Culture).LCID
$iniContent = @"
[shortcuts]
startmenu=1
desktop=1
explorer=1

[language]
language=$LCID
"@

# Create the ini file for the installer
New-Item $iniFile -type file -force -value $iniContent

Get-ChocolateyWebFile $packageName $installerPath $url

# Download the file to $PSScriptRoot.
# Using Chocolatey’s Installer-ChocolateyPackage function isn’t a good idea here
# because the path where the installer is downloaded could change and
# the ini file needs to be in the same folder to work.
Install-ChocolateyInstallPackage $packageName $fileType $silentArgs $installerPath
