$ErrorActionPreference = 'Stop'

$version = '6.2.0'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$progDir  = "$toolsDir\octave"

$osBitness = Get-OSArchitectureWidth

$packageArgs = @{
  PackageName    = 'octave.portable'
  UnzipLocation  = $toolsDir
  Url            = 'https://ftp.gnu.org/gnu/octave/windows/octave-6.2.0-w32.7z'
  Url64          = 'https://ftp.gnu.org/gnu/octave/windows/octave-6.2.0-w64.7z'
  Checksum       = '4f205b4d9c8a6f03895c4c1e1aefa4c32d2d0b290976831bd52c3ab951414081'
  Checksum64     = '2011d03a651f29310267893633caf5d8b9394da3799da6f01c225b32630d0091'
  ChecksumType   = 'sha256'
  ChecksumType64 = 'sha256'
}
Install-ChocolateyZipPackage @packageArgs

# Rename unzipped folder
If (Test-Path "$toolsDir\octave-$version-w$osBitness") {
  Rename-Item -Path "$toolsDir\octave-$version-w$osBitness" -NewName "octave"
}
If (Test-Path "$toolsDir\octave-$version") {
  Rename-Item -Path "$toolsDir\octave-$version" -NewName "octave"
}

# Don't create shims for any executables
$files = Get-ChildItem "$toolsDir" -include *.exe -exclude "octave-cli.exe" -recurse
foreach ($file in $files) {
  New-Item "$file.ignore" -type file -force | Out-Null
}
# Link batch
Install-BinFile -Name "octave" -Path "$progDir\bin\octave-cli.exe"

# Create desktop shortcut
$desktop = $([System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::DesktopDirectory))
$link = Join-Path $desktop "Octave.lnk"
if (!(Test-Path $link)) {
  Install-ChocolateyShortcut -ShortcutFilePath "$link" -TargetPath "$progDir\octave.vbs" -WorkingDirectory "$progDir" -Arguments '--force-gui' -IconLocation "$progDir\share\octave\$version\imagelib\octave-logo.ico"
}
