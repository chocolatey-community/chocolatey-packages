$version = '5.1.0'

$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$progDir        = "$toolsDir\octave"

$osBitness      = Get-OSArchitectureWidth

$packageArgs = @{
    PackageName     = 'octave.portable'
    UnzipLocation   = $toolsDir
    Url             = 'https://ftp.gnu.org/gnu/octave/windows/octave-5.1.0-w32.7z'
    Url64           = 'https://ftp.gnu.org/gnu/octave/windows/octave-5.1.0-w64.7z'
    Checksum        = 'b7a8fb8c78c781285ab12f4dedbdc07fdc42c3a03da812ffe2eaa77d49872618'
    Checksum64      = 'b13549ad2f69654e25d51c70aad9dfe0635007303d855550c7c6dc2f73af8035'
    ChecksumType    = 'sha256'
    ChecksumType64  = 'sha256'
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
