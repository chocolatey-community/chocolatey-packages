$url = '{{DownloadUrl}}'
$unzipLocation = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
Install-ChocolateyZipPackage '{{PackageName}}' "$url" "$unzipLocation"

$testdiskexePath = Join-Path "$unzipLocation" "testdisk-6.13\testdisk_win.exe"
Install-ChocolateyDesktopLink "$testdiskexePath"

$desktop = [Environment]::GetFolderPath("Desktop")

if (Test-Path "$desktop\TestDisk.lnk") {Remove-Item "$desktop\TestDisk.lnk"}
    
Rename-Item "$desktop\testdisk_win.exe.lnk" "TestDisk.lnk"


$startMenu = $([System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::StartMenu))

if (Test-Path "$startMenu\Programs\TestDisk.lnk") {Remove-Item "$startMenu\Programs\TestDisk.lnk"}

Copy-Item "$desktop\TestDisk.lnk" "$startMenu\Programs\TestDisk.lnk"