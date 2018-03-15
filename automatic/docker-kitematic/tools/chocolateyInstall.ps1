$ErrorActionPreference = 'Stop'

$packageName = 'docker-kitematic'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  PackageName    = $packageName
  FileFullPath64 = Get-Item $toolsPath\kitematic.zip
  Destination    = $toolsPath
}
Get-ChocolateyUnzip @packageArgs

# Don't create shims for anything other than Kitematic
$files = Get-ChildItem "$toolsPath" -include *.exe -exclude Kitematic.exe -recurse
foreach ($file in $files) {
  New-Item "$file.ignore" -type file -force | Out-Null
}

# Create desktop shortcut
$desktop = $([System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::DesktopDirectory))
$link = Join-Path $desktop "Kitematic.lnk"
if (!(Test-Path $link)) {
    Install-ChocolateyShortcut -ShortcutFilePath "$link" -TargetPath "$toolsPath\Kitematic.exe" -WorkingDirectory "$toolsPath"
}
