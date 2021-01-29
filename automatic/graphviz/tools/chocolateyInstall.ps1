$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = 'graphviz'
  fileType       = 'exe'
  file           = "$toolsPath\graphviz-install-2.44.1-win32.exe"
  file64         = "$toolsPath\graphviz-install-2.44.1-win64.exe"
  silentArgs     = '/S'
  validExitCodes = @(0)
  softwareName   = 'Graphviz*'
}

Install-ChocolateyPackage @packageArgs
Remove-Item $toolsPath\*.exe -ea 0

$packageName = $packageArgs.packageName
$installLocation = Get-AppInstallLocation $packageArgs.softwareName
if (!$installLocation)  { Write-Warning "Can't find $packageName install location"; return 1 }
Write-Host "$packageName installed to '$installLocation'"

Get-ChildItem "$installLocation\bin" -Filter "*.exe" | ForEach {
    Write-Debug "File to be shimmed: $($_.Name)"
    Install-BinFile $_.BaseName $_.FullName
}
