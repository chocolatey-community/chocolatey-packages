$version = '4.4.1'

$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$progDir        = "$toolsDir\octave"

$osBitness      = Get-OSArchitectureWidth

$packageArgs = @{
    PackageName     = 'octave.portable'
    UnzipLocation   = $toolsDir
    Url             = 'https://ftp.gnu.org/gnu/octave/windows/octave-4.4.1-w32.zip'
    Url64           = 'https://ftp.gnu.org/gnu/octave/windows/octave-4.4.1-w64.zip'
    Checksum        = 'e2fe876c72feb396af2ff4c4a7a893cbd802634ac1f6cadd05f29fb8d4bf26e2'
    Checksum64      = '69482931038a63fa258a58e23c4745015cbf0a6283dec92dfd866d8dfb7807c0'
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
