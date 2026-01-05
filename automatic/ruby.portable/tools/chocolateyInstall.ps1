$ErrorActionPreference = 'Stop'

$toolsPath = "$(Split-Path -Path ${MyInvocation}.MyCommand.Definition -Parent)"
$rubyDir = "$(Join-Path -Path ${toolsPath} -ChildPath (
  Join-Path -Path 'ruby' -ChildPath 'ruby*' -ChildPath 'bin'
) -Resolve)"

Write-Information "Ruby portable interpreter directory: '${rubyDir}'."

$exeName = 'rubyinstaller-4.0.2-1-x64.7z'
$exePath = "$(Join-Path -Path ${toolsPath} -ChildPath ${exeName})"

$packageArgs = @{
  File64      = ${exePath}
  Destination = (Join-Path -Path ${toolsPath} -ChildPath 'ruby')
  PackageName = ${Env:ChocolateyPackageName}
}

Get-ChocolateyUnzip @packageArgs

# Add shims for .bat and .cmd files, in the bin folder, that Chocolatey CLI will
# not shim.
Get-ChildItem -Path "${rubyDir}\*" -Include (
  '*.bat',
  '*.cmd'
) -File | ForEach-Object {
  Install-BinFile -Name $_.BaseName -Path $_.FullName
}

Get-ChildItem -Path ${toolsPath} -Filter '*.7z' -File | ForEach-Object {
  Remove-Item -LiteralPath $_.FullName -Force -ErrorAction SilentlyContinue
}
