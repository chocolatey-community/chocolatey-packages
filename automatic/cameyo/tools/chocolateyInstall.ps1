$url = '{{DownloadUrl}}'
$scriptPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$exePath = Join-Path "$scriptPath" "Cameyo.exe"
if (Test-Path "$exePath") {Remove-Item "$exePath"}
Get-ChocolateyWebFile '{{PackageName}}' "$exePath" "$url"

Install-ChocolateyDesktopLink "$exePath"

$desktop = [Environment]::GetFolderPath("Desktop")

if (Test-Path "$desktop\Cameyo.lnk") {Remove-Item "$desktop\Cameyo.lnk"}

Rename-Item "$desktop\Cameyo.exe.lnk" "Cameyo.lnk"


$startMenu = $([System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::StartMenu))

if (Test-Path "$startMenu\Programs\Cameyo.lnk") {Remove-Item "$startMenu\Programs\Cameyo.lnk"}

Copy-Item "$desktop\Cameyo.lnk" "$startMenu\Programs\Cameyo.lnk"
