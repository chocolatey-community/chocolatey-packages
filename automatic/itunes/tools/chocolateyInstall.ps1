$ErrorActionPreference = 'Stop';

$version = '12.11.4.15'

$packageArgs = @{
  packageName    = 'iTunes'
  fileType       = 'msi'
  url            = 'https://secure-appldnld.apple.com/itunes12/071-25049-20210809-F69E52C8-F94A-11EB-8496-03B06A2FDD26/iTunesSetup.exe'
  url64bit       = 'https://secure-appldnld.apple.com/itunes12/071-25047-20210809-F69EB204-F94A-11EB-9CEE-02B06A2FDD26/iTunes64Setup.exe'
  softwareName   = 'iTunes'
  checksum       = 'B8DC7922CFC2DC5704F1E64037DB0366465ED1A37E5C405587825F04EA629AE8'
  checksumType   = 'sha256'
  checksum64     = '0f9beca9148f5ced1ab77b4024d462c54846c4b3e8a4e1dcbeff730b5e5c66c8'
  checksumType64 = 'sha256'
  silentArgs     = "/qn /norestart"
  validExitCodes = @(0, 2010, 1641)
  unzipLocation  = Get-PackageCacheLocation
}

$app = Get-UninstallRegistryKey -SoftwareName $packageArgs.softwareName | Select-Object -first 1

if ($app -and ([version]$app.DisplayVersion -ge [version]$version) -and ($env:ChocolateyForce -ne $true)) {
  Write-Host "iTunes $version or higher is already installed."
  Write-Host "No need to download and install again"
  return;
}

Install-ChocolateyZipPackage @packageArgs

$msiFileList = (Get-ChildItem -Path $packageArgs.unzipLocation -Filter '*.msi' | Where-Object {
  $_.Name -notmatch 'AppleSoftwareUpdate*.msi'
})

foreach ($msiFile in $msiFileList) {
  $packageArgs.packageName = $msiFile.Name
  $packageArgs.file = $msiFile.FullName
  Install-ChocolateyInstallPackage @packageArgs
}

Remove-Item $packageArgs.unzipLocation -Recurse -Force -ea 0
