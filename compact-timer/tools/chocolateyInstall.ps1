$packageName = '{{PackageName}}'
$url = '{{DownloadUrl}}'
$binRoot = "$env:systemdrive\tools"
$unzipLocation = "$binRoot\Compact Timer"

Install-ChocolateyZipPackage $packageName $url $unzipLocation

$desktop = "$([Environment]::GetFolderPath("Desktop"))"
$startMenu = "$([System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::StartMenu))\Programs"

Install-ChocolateyDesktopLink "$unzipLocation\CompactTimer.exe"
Rename-Item -Path "$desktop\CompactTimer.exe.lnk" -NewName "Compact Timer.lnk"
Copy-Item "$desktop\Compact Timer.lnk" -Destination "$startMenu"