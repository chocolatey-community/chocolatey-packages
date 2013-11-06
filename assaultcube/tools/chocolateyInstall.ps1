$packageName = '{{PackageName}}'
$url = 'http://sourceforge.net/projects/actiongame/files/AssaultCube Version {{PackageVersion}}/AssaultCube_v{{PackageVersion}}.exe/download'
$zipPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)\assaultcube.zip"
$folder = "$env:ProgramFiles\AssaultCube"
$folderx86 = "${env:ProgramFiles(x86)}\AssaultCube"
if (Test-Path $folder) {
    $unzipLocation = $folder
} else {
    $unzipLocation = $folderx86
}

# Uninstalling of old 1.1.0.4 version if necessary

$oldUninstall = "$env:ProgramFiles\AssaultCube_v1.1.0.4\Uninstall.exe"
$oldUninstallx86 = "${env:ProgramFiles(x86)}\AssaultCube_v1.1.0.4\Uninstall.exe"

if (Test-Path $oldUninstall) {
    Start-ChocolateyProcessAsAdmin '/S' $oldUninstall
}

if (Test-Path $oldUninstallx86) {
    Start-ChocolateyProcessAsAdmin '/S' $oldUninstallx86
}

# Installation of new version

Install-ChocolateyPackage $packageName 'exe' '/S' $url
Install-ChocolateyZipPackage $packageName $zipPath $unzipLocation