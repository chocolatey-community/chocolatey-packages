$version = '4.4.0'

$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$progDir        = "$toolsDir\octave"

$osBitness      = Get-OSArchitectureWidth

$packageArgs = @{
    PackageName     = 'octave.portable'
    UnzipLocation   = $toolsDir
    Url             = 'https://ftp.gnu.org/gnu/octave/windows/octave-4.4.0-w32.zip'
    Url64           = 'https://ftp.gnu.org/gnu/octave/windows/octave-4.4.0-w64.zip'
    Checksum        = '26d4874d7eba14879d837666678006254a7db31780f724f5e214864989e491ce'
    Checksum64      = 'ef8aa3c1eb1454d5c92ee780aa6a3df1f008e74fcd051d56b91dde59c7ac7a17'
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
