$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path -parent $MyInvocation.MyCommand.Definition
$silentArgs     = "/quiet /norestart /l*v `"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
$fileType   = 'msi'

$packageArgs = @{
  packageName = $env:ChocolateyPackageName
  file        = gi $toolsPath\*_x32.zip
  file64      = gi $toolsPath\*_x64.zip
  destination = $toolsPath
  softwareName = 'Paint.NET*'
}

Get-ChocolateyUnzip @packageArgs
Remove-Item $toolsPath\*.zip -ea 0

$FileFullPath = Get-ChildItem $toolsPath -Recurse -Include *.msi | Sort-Object -Descending | Select-Object -First 1
$packageArgs.Remove('file64')
$packageArgs['file'] = $FileFullPath

Install-ChocolateyInstallPackage @packageArgs

$installLocation = Get-AppInstallLocation $packageArgs.softwareName
if (!$installLocation)  { Write-Warning "Can't find $packageName install location"; return }
Write-Host "$packageName installed to '$installLocation'"

Register-Application "$installLocation\PaintDotNet.exe" paint
Write-Host "$packageName registered as paint"