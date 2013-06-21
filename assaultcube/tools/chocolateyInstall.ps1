$packageName = '{{PackageName}}'
$url = '{{DownloadUrl}}'
$zipPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)\assaultcube.zip"
$assaultcubePath = 
if (Test-Path "$env:ProgramFiles\AssaultCube_v{{PackageVersion}}") {
    $unzipLocation = "$env:ProgramFiles\AssaultCube_v{{PackageVersion}}"
} else {
    $unzipLocation = "${env:ProgramFiles(x86)}\AssaultCube_v{{PackageVersion}}"
}

Install-ChocolateyPackage $packageName 'exe' '/S' $url
Install-ChocolateyZipPackage $packageName $zipPath $unzipLocation