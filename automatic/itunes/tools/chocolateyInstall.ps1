$ErrorActionPreference = 'Stop';

$version = '12.10.2.3'

$packageArgs = @{
  packageName    = 'iTunes'
  fileType       = 'msi'
  url            = 'http://updates-http.cdn-apple.com/2019/windows/061-30719-20191029-880E8B50-FA6B-11E9-A9F5-D674B62FDC30/iTunesSetup.exe'
  url64bit       = 'http://updates-http.cdn-apple.com/2019/windows/061-30715-20191029-880EDD94-FA6B-11E9-8A90-D774B62FDC30/iTunes64Setup.exe'
  softwareName   = 'iTunes'
  checksum       = '8C9C766FF21D4F0856078EA57CB6AC5B870911C915AC32847481685B2012DB89'
  checksumType   = 'sha256'
  checksum64     = '27c3c389aadd3926b654f00cbb78075aa1c7afb166dd04e95ca4abb3c80c1d6c'
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
