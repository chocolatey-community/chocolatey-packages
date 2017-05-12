$ErrorActionPreference = 'Stop';

$version = '12.6'

$packageArgs = @{
  packageName    = 'iTunes'
  fileType       = 'msi'
  url            = 'https://secure-appldnld.apple.com/itunes12/031-85228-20170321-A9683868-0E6A-11E7-B70F-EF1900A0ED6C/iTunesSetup.exe'
  url64bit       = 'https://secure-appldnld.apple.com/itunes12/031-86712-20170321-56E4FC3E-0E6A-11E7-AFAD-241900A0ED6C/iTunes64Setup.exe'
  softwareName   = 'iTunes'
  checksum       = '03b41f6d23303f8ff650332d44014ef9cda9c9f21ba8c75ccfa5e4a6b9584a19'
  checksumType   = 'sha256'
  checksum64     = 'b478be402e1997227495f1e5bad7bdce24c704df61644c35280584bbf5a5223e'
  checksumType64 = 'sha256'
  silentArgs     = "/qn /norestart"
  validExitCodes = @(0, 2010, 1641)
  unzipLocation  = Get-PackageCacheLocation
}

$app = Get-UninstallRegistryKey -SoftwareName $packageArgs.softwareName | select -first 1

if ($app -and ([version]$app.DisplayVersion -ge [version]$version) -and ($env:ChocolateyForce -ne $true)) {
  Write-Host "iTunes $version or higher is already installed."
  Write-Host "No need to download and install again"
  return;
}

Install-ChocolateyZipPackage = @packageArgs

$msiFileList = (Get-ChildItem -Path $packageArgs.unzipLocation -Filter '*.msi' | Where-Object {
  $_.Name -notmatch 'AppleSoftwareUpdate*.msi'
})

foreach ($msiFile in $msiFileList) {
  $packageArgs.packageName = $msiFile.Name
  $packageArgs.file = $msiFile.FullName
  Install-ChocolateyInstallPackage @packageArgs
}

Remove-Item $packageArgs.unzipLocation -Recurse -Force -ea 0
