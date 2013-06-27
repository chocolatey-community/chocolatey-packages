$desktop = [Environment]::GetFolderPath("Desktop")
if (Test-Path "$desktop\PhotoRec.lnk") {Remove-Item "$desktop\PhotoRec.lnk"}

$startMenu = $([System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::StartMenu))
if (Test-Path "$startMenu\Programs\PhotoRec.lnk") {Remove-Item "$startMenu\Programs\PhotoRec.lnk"}