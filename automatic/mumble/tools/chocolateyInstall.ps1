$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageName = $env:ChocolateyPackageName

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'msi'
  file           = "$toolsPath\mumble_client-1.4.287.x64.msi"
  softwareName   = 'Mumble*'
  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes = @(0, 2010, 1641)
}

$pp = Get-PackageParameters
if ($pp['IncludeAll']) {
  $packageArgs['silentArgs'] += " ADDLOCAL=ALL"
}

Install-ChocolateyInstallPackage @packageArgs

Get-ChildItem $toolsPath\*.msi | ForEach-Object { Remove-Item $_ -ea 0; if (Test-Path $_) { Set-Content "$_.ignore" } }

$installLocation = Get-AppInstallLocation $packageArgs.softwareName
if ($installLocation) {
  Write-Host "$packageName installed to '$installLocation'"
  # We avoid globbing patterns when possible, and we want to ensure
  # that the correct executable is registered. As such the path is hard
  # coded.
  $executable = "$installLocation\$packageName.exe"

  if (!(Test-Path $executable)) {
    $executable = "$installLocation\client\$packageName.exe"
  }

  Register-Application -ExePath $executable -Name $packageName
  Write-Host "$executable registered as $packageName"
}
else {
  Write-Warning "Can't find $packageName install location"
}
