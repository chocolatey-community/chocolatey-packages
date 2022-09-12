$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = 'graphviz'
  fileType       = 'exe'
  file64         = "$toolsPath\graphviz-6.0.1 (64-bit) EXE installer.exe"
  silentArgs     = '/S'
  validExitCodes = @(0)
  softwareName   = 'Graphviz*'
}

Install-ChocolateyPackage @packageArgs
Remove-Item $toolsPath\*.exe -ea 0

$packageName = $packageArgs.packageName
$installLocation = Get-AppInstallLocation $packageArgs.softwareName
if (!$installLocation)  { Write-Warning "Can't find $packageName install location"; return }
Write-Host "$packageName installed to '$installLocation'"

Get-ChildItem "$installLocation\bin" -Filter "*.exe" | ForEach-Object {
    Write-Debug "File to be shimmed: $($_.Name)"
    Install-BinFile $_.BaseName $_.FullName
}
