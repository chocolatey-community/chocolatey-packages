$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'msi'
  url            = 'https://inkscape.org/gallery/item/44473/inkscape-1.3.1_2023-11-16_91b66b0783-x86_ulhsqfz.msi'
  checksum       = 'E49D533D0D741509A7B982541C9014F4EF7C20FF9063D602E211DE09717D523E'
  checksumType   = 'sha256'
  file64         = "$toolsPath\inkscape-1.3.1_2023-11-16_91b66b0783-x64_yOr62Fw.msi"
  softwareName   = 'InkScape*'
  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes = @(0)
}

[array]$key = Get-UninstallRegistrykey $packageArgs['softwareName']
if ($key.Count -eq 1) {
  if ($key[0].DisplayVersion -eq '1.3.1') {
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
  Install-BinFile 'inkscape' $installLocation\bin\inkscape.exe
  Write-Host "$packageName installed to '$installLocation'"
}
else { Write-Warning "Can't find $PackageName install location" }
