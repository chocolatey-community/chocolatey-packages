$ErrorActionPreference = 'Stop';
$iconName  = 'BeCyIconGrabber.lnk'
$startIcon = (Join-Path ([environment]::GetFolderPath([environment+specialfolder]::Programs)) $iconName)

if (Test-Path $starticon) {
	Remove-Item $starticon
	Write-Host -ForegroundColor green 'Removed ' $starticon
} else {
	Write-Host -ForegroundColor yellow 'Did not find ' $starticon ' to remove'
}