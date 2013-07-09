$scriptPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$exeFile = "YUMI-0.1.0.0.exe"
$url = 'http://www.pendrivelinux.com/downloads/YUMI/YUMI-0.1.0.0.exe'
$exeFileLink = "YUMI.lnk"
$exePath = Join-Path "$scriptPath" "$exeFile"
if (Test-Path "$exePath") {Remove-Item "$exePath"}
Get-ChocolateyWebFile 'yumi' "$exePath" "$url"

Install-ChocolateyDesktopLink "$exePath"

$desktop = [Environment]::GetFolderPath("Desktop")

if (Test-Path "$desktop\$exeFileLink") {Remove-Item "$desktop\$exeFileLink"}
    
Rename-Item "$desktop\$exeFile.lnk" "$exeFileLink"


$startMenu = $([System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::StartMenu))

if (Test-Path "$startMenu\Programs\$exeFileLink") {Remove-Item "$startMenu\Programs\$exeFileLink"}

Copy-Item "$desktop\$exeFileLink" "$startMenu\Programs\$exeFileLink"