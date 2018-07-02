$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageName = $env:ChocolateyPackageName

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'msi'
  file           = "$toolsPath\"
  softwareName   = 'Mumble*'
  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes = @(0, 2010, 1641)
}

Install-ChocolateyInstallPackage @packageArgs

ls $toolsPath\*.msi | % { rm $_ -ea 0; if (Test-Path $_) { sc "$_.ignore" } }

$installLocation = Get-AppInstallLocation $packageArgs.softwareName
if ($installLocation) {
  Write-Host "$packageName installed to '$installLocation'"
  Register-Application "$installLocation\$packageName.exe"
  Write-Host "$packageName registered as $packageName"
}
else {
  Write-Warning "Can't find $packageName install location"
}
