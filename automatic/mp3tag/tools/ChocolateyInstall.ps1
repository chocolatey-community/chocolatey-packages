$packageName = '{{PackageName}}'
$fileType = 'exe'
$version = '{{PackageVersion}}'
$silentArgs = '/S'
$url = '{{DownloadUrl}}'
$PSScriptRoot = Split-Path -parent $MyInvocation.MyCommand.Definition

# The installer doesn’t like being renamed. The installation wouldn’t be
# silent if it is renamed. Therefore the original filename is parsed
# from the URL
$installerPath = Join-Path $PSScriptRoot $url.Split('/')[-1]
$iniFile = Join-Path $PSScriptRoot 'Mp3tagSetup.ini'

# Automatic language selection
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
