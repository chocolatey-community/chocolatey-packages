$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'msi'
  url            = 'https://inkscape.org/gallery/item/18475/inkscape-1.0-x86.msi'
  checksum       = 'C0D5F7F58D42611FBCFF2AC232C48AAD6574D8A1D9A25B18D0A081969B1FDEAC'
  checksumType   = 'sha256'
  file64         = "$toolsPath\inkscape-1.0-x64.msi"
  softwareName   = 'InkScape*'
  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes = @(0)
}

[array]$key = Get-UninstallRegistrykey $packageArgs['softwareName']
if ($key.Count -eq 1) {
  if ($key[0].DisplayVersion -eq '1.0') {
    Write-Host "Software already installed"
    return
  }
  else {
    # We need to do it this way, as PSChildName isn't available in POSHv2
    $msiId = $key[0].UninstallString -replace '^.*MsiExec\.exe\s*\/I', ''
    Uninstall-ChocolateyPackage -packageName $packageArgs['packageName'] `
      -fileType $packageArgs['fileType'] `
      -silentArgs "$msiId $($packageArgs['silentArgs'] -replace 'MsiInstall','MsiUninstall')" `
      -validExitCodes $packageArgs['validExitCodes'] `
      -file ''
  }
}
elseif ($key.Count -gt 1) {
  Write-Warning "$($key.Count) matches found!"
  Write-Warning "To prevent accidental data loss, no programs will be uninstalled."
  Write-Warning "This will most likely cause a 1603/1638 failure when installing InkScape."
  Write-Warning "Please uninstall InkScape before installing this package."
}

if ((Get-OSArchitectureWidth 32) -or ($env:chocolateyForceX86 -eq $true)) {
  Install-ChocolateyPackage @packageArgs
}
else {
  Install-ChocolateyInstallPackage @packageArgs
}

Get-ChildItem $toolsPath\*.msi | ForEach-Object { Remove-Item $_ -ea 0; if (Test-Path $_) { Set-Content "$_.ignore" } }

$packageName = $packageArgs.packageName
$installLocation = Get-AppInstallLocation $packageArgs['softwareName']
if ($installLocation) {
  Install-BinFile 'inkscape' $installLocation\inkscape.exe
  Write-Host "$packageName installed to '$installLocation'"
}
else { Write-Warning "Can't find $PackageName install location" }
