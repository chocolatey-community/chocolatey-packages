$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  PackageName    = $env:ChocolateyPackageName
  fileType       = "msi"
  file64         = "$toolsPath\paint.net.5.0.13.winmsi.x64.msi"
  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes = @(0, 1641, 3010)
  softwareName   = 'Paint.NET*'
}

Install-ChocolateyInstallPackage @packageArgs
Get-ChildItem $toolsPath\*.msi | ForEach-Object { Remove-Item $_ -ea 0; if (Test-Path $_) { Set-Content "$_.ignore" '' }}

$packageName = $packageArgs.packageName
$installLocation = Get-AppInstallLocation $packageArgs.softwareName
if (!$installLocation)  { Write-Warning "Can't find $packageName install location"; return }
Write-Host "$packageName installed to '$installLocation'"

Register-Application "$installLocation\PaintDotNet.exe" paint
Write-Host "$packageName registered as paint"
