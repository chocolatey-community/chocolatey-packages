$desktop = [Environment]::GetFolderPath("Desktop")
if (Test-Path "$desktop\Cameyo.lnk") {Remove-Item "$desktop\Cameyo.lnk"}

$startMenu = $([System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::StartMenu))
if (Test-Path "$startMenu\Programs\Cameyo.lnk") {Remove-Item "$startMenu\Programs\Cameyo.lnk"}
