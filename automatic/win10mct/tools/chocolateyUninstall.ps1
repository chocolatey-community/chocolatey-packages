$exeName = "MediaCreationTool.exe"
$AppPathKey = "Registry::HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\$exeName"

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

$shortcutName = 'Windows Media 10 Creation Tool.lnk'
$exePath = Join-Path $toolsDir $exeName 

#Uninstall-ChocolateyZipPackage $packageName windows10-media-creation-tool.zip

If (Test-Path $AppPathKey) {Remove-Item "$AppPathKey" -Force -Recurse -EA SilentlyContinue | Out-Null}

$desktopshortcut = (Join-Path ([System.Environment]::GetFolderPath("Desktop")) $shortcutName)
$startshortcut = (Join-Path ([System.Environment]::GetFolderPath("Programs")) $shortcutName)

if (Test-Path $desktopshortcut) {
	Remove-Item $desktopshortcut
	Write-Host -ForegroundColor white 'Removed ' $desktopshortcut
} else {
	Write-Host -ForegroundColor yellow 'Did not find ' $desktopshortcut 'to remove'
}

if (Test-Path $startshortcut) {
	Remove-Item $startshortcut
	Write-Host -ForegroundColor white 'Removed ' $startshortcut
} else {
	Write-Host -ForegroundColor yellow 'Did not find ' $startshortcut 'to remove'
}