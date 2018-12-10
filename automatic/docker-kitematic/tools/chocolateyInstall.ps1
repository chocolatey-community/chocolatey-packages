$ErrorActionPreference = 'Stop'

$packageName = 'docker-kitematic'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
$kitematicExe = Join-Path $toolsPath "Kitematic.exe"

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
    Install-ChocolateyShortcut -ShortcutFilePath "$link" -TargetPath $kitematicExe -WorkingDirectory "$toolsPath"
}

# Create sym-link for docker tray menu
$kitematicDir = Join-Path $env:ProgramFiles "Docker\Kitematic"
$kitematicLink = Join-Path $kitematicDir "kitematic.exe"
New-Item -Path $kitematicDir -ItemType Directory -Force | Out-Null
if (!(Test-Path $kitematicLink)) {
	& cmd /c mklink $kitematicLink $kitematicExe
}