$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
    PackageName    = $env:ChocolateyPackageName
    FileFullPath   = gi $toolsPath\*.zip
    Destination    = $toolsPath
}
Get-ChocolateyUnzip @packageArgs
rm $toolsPath\*.zip -ea 0

$packageArgs = @{
  PackageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  file           = gi $toolsPath\*.exe
  silentArgs     = '/auto'
  validExitCodes = @(0, 1641, 3010)
  softwareName   = 'Paint.NET*'
}

Install-ChocolateyInstallPackage @packageArgs
ls $toolsPath\*.exe | % { rm $_ -ea 0; if (Test-Path $_) { sc "$_.ignore" }}

$packageName = $packageArgs.packageName
$installLocation = Get-AppInstallLocation $packageArgs.softwareName
if (!$installLocation)  { Write-Warning "Can't find $packageName install location"; return }
Write-Host "$packageName installed to '$installLocation'"

Register-Application "$installLocation\PaintDotNet.exe" paint
Write-Host "$packageName registered as paint"
