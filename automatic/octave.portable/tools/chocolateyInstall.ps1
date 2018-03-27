$version = '4.2.2'

$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$progDir        = "$toolsDir\octave"

$osBitness      = Get-ProcessorBits

$packageArgs = @{
    PackageName     = 'octave.portable'
    UnzipLocation   = $toolsDir
    Url             = 'https://ftp.gnu.org/gnu/octave/windows/octave-4.2.2-w32.zip'
    Url64           = 'https://ftp.gnu.org/gnu/octave/windows/octave-4.2.2-w64.zip'
    Checksum        = '1446997f71ed8fee725d17e0850087f14b59fba36aacbc0fea799943a6eaad20'
    Checksum64      = 'f41d561c53fd193510f337dd379c0e0853df830fc5dced4dd98a6c4d65535117'
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
