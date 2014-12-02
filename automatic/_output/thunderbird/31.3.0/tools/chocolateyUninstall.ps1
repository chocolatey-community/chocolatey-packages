$unfile = "Mozilla Thunderbird\uninstall\helper.exe"

if (Test-Path "${Env:ProgramFiles(x86)}\$unfile") {
  $unpath = "${Env:ProgramFiles(x86)}\$unfile"
}
if (Test-Path "${Env:ProgramFiles}\$unfile") {
  $unpath = "${Env:ProgramFiles}\$unfile"
}
Uninstall-ChocolateyPackage 'thunderbird' 'exe' '-ms' "$unpath"

Write-Host The Thunderbird profiles in %appdata% and %localappdata% must be deleted manually if desired.
