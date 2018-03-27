$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$progDir    = "$toolsDir\octave"

# Remove desktop shortcut
$desktop = $([System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::DesktopDirectory))
$link = Join-Path $desktop "Octave.lnk"
If (Test-Path $link) {
    Remove-Item "$link"
}

# Unlink batch
Uninstall-BinFile -Name "octave" -Path "$progDir\bin\octave-cli.exe"
