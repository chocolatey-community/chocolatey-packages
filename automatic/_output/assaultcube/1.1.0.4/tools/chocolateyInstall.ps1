$packageName = 'assaultcube'
$url = 'http://switch.dl.sourceforge.net/project/actiongame/AssaultCube Version 1.1.0.4/AssaultCube_v1.1.0.4.exe'
$zipPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)\assaultcube.zip"
$folder = "$env:ProgramFiles\AssaultCube"
$folderx86 = "${env:ProgramFiles(x86)}\AssaultCube"
if (Test-Path $folder) {
    $unzipLocation = $folder
} else {
    $unzipLocation = $folderx86
}

Install-ChocolateyPackage $packageName 'exe' '/S' $url
Install-ChocolateyZipPackage $packageName $zipPath $unzipLocation