
# Remove desktop shortcut
$desktop = $([System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::DesktopDirectory))
$link = Join-Path $desktop "Kitematic.lnk"
If (Test-Path $link) {
    Remove-Item "$link"
}

# Remove docker tray sym-link
$kitematicDir = Join-Path $env:ProgramFiles "Docker\Kitematic"
$kitematicLink = Join-Path $kitematicDir "kitematic.exe"
if (Test-Path $kitematicLink) {
	Remove-Item $kitematicLink
}
