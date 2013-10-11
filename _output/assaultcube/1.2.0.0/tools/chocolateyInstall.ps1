$packageName = 'assaultcube'
$url = 'http://switch.dl.sourceforge.net/project/actiongame/AssaultCube Version 1.2.0.0/AssaultCube_v1.2.0.0.exe'
$zipPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)\assaultcube.zip"
$assaultcubePath = 
if (Test-Path "$env:ProgramFiles\AssaultCube_v1.2.0.0") {
    $unzipLocation = "$env:ProgramFiles\AssaultCube_v1.2.0.0"
} else {
    $unzipLocation = "${env:ProgramFiles(x86)}\AssaultCube_v1.2.0.0"
}

Install-ChocolateyPackage $packageName 'exe' '/S' $url
Install-ChocolateyZipPackage $packageName $zipPath $unzipLocation