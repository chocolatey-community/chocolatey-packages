$url = '{{DownloadUrl}}'
$unzipLocation = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
Install-ChocolateyZipPackage '{{PackageName}}' "$url" "$unzipLocation"

$testdiskexePath = Join-Path "$unzipLocation" "testdisk-6.13\photorec_win.exe"
Install-ChocolateyDesktopLink "$testdiskexePath"

$desktop = [Environment]::GetFolderPath("Desktop")

if (Test-Path "$desktop\PhotoRec.lnk") {Remove-Item "$desktop\PhotoRec.lnk"}
    
Rename-Item "$desktop\photorec_win.exe.lnk" "PhotoRec.lnk"


$startMenu = $([System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::StartMenu))

if (Test-Path "$startMenu\Programs\PhotoRec.lnk") {Remove-Item "$startMenu\Programs\PhotoRec.lnk"}

Copy-Item "$desktop\PhotoRec.lnk" "$startMenu\Programs\PhotoRec.lnk"