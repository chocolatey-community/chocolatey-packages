$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageName = $env:ChocolateyPackageName

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'msi'
  file           = "$toolsPath\cdbxp_setup_4.5.8.7041.msi"
  file64         = "$toolsPath\cdbxp_setup_x64_4.5.8.7041.msi"
  softwareName   = 'cdburnerxp*'
  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$packageName.$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes = @(0, 2010, 1641)
}

Install-ChocolateyInstallPackage @packageArgs

Get-ChildItem $toolsPath\*.msi | ForEach-Object { Remove-Item $_ -ea 0; if (Test-Path $_) { Set-Content "$_.ignore" '' } }

$installLocation = Get-AppInstallLocation $packageArgs.softwareName
if ($installLocation) {
  Write-Host "$packageName installed to '$installLocation'"
  Register-Application "$installLocation\cdbxpp.exe"
  Write-Host "$packageName registered as cdbxpp"
} else {
  Write-Warning "Can't find $packageName install location"
}
