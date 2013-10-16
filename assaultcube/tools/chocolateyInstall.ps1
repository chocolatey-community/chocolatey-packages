$packageName = '{{PackageName}}'
$url = '{{DownloadUrl}}'
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