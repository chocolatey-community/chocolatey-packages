$desktop = [Environment]::GetFolderPath("Desktop")
if (Test-Path "$desktop\TestDisk.lnk") {Remove-Item "$desktop\TestDisk.lnk"}

$startMenu = $([System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::StartMenu))
if (Test-Path "$startMenu\Programs\TestDisk.lnk") {Remove-Item "$startMenu\Programs\TestDisk.lnk"}