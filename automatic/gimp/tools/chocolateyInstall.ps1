$ErrorActionPreference = 'Stop'

$fallbackUrl32 = 'https://download.gimp.org/gimp/v3.2/windows/gimp-3.2.6-setup.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://download.gimp.org/gimp/v3.2/windows/gimp-3.2.6-setup.exe'
  softwareName   = 'GIMP*'
  checksum       = '9337cccbc01d4098ee7a3dab215b3afbe6ece99c5287c92441d6f12cf541ebca'
  checksumType   = 'sha256'
  silentArgs     = "/VERYSILENT /NORESTART /RESTARTEXITCODE=3010 /SUPPRESSMSGBOXES /SP- /LOG=`"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).InnoInstall.log`""
  validExitCodes = @(0)
}

# The GIMP installer does not remove existing GIMP installations on upgrade,
# so any installed version whose DisplayVersion differs from the package
# version is uninstalled here before the new version is installed.
$uninstallArgs = @{
  packageName    = $packageArgs.packageName
  fileType       = 'exe'
  silentArgs     = "/VERYSILENT /NORESTART /SUPPRESSMSGBOXES /SP- /LOG=`"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).InnoUninstall.log`""
  validExitCodes = @(0)
}

[array]$keys = Get-UninstallRegistryKey -SoftwareName $packageArgs.softwareName
foreach ($k in $keys) {
  if ($k.DisplayVersion -eq $env:chocolateyPackageVersion) { continue }
  $uninstallArgs['file'] = $k.UninstallString
  Uninstall-ChocolateyPackage @uninstallArgs
}

Try {
    Get-WebHeaders -Url $packageArgs.url
} Catch {
    Write-Warning "The mirror URL is not available, falling back to the main site"
    $packageArgs.url = $fallbackUrl32
}

Install-ChocolateyPackage @packageArgs
