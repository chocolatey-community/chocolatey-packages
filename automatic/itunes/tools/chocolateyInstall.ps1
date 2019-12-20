$ErrorActionPreference = 'Stop';

$version = '12.10.3.1'

$packageArgs = @{
  packageName    = 'iTunes'
  fileType       = 'msi'
  url            = 'http://updates-http.cdn-apple.com/2019/windows/061-62390-20191210-344B958C-1BAC-11EA-B424-5ECFC722D531/iTunesSetup.exe'
  url64bit       = 'http://updates-http.cdn-apple.com/2019/windows/061-62393-20191210-344C270E-1BAC-11EA-A3D8-5FCFC722D531/iTunes64Setup.exe'
  softwareName   = 'iTunes'
  checksum       = '1777232249ADB731D1B5C7B484C87C26D55757D3AC2B4B31140B4915449F4003'
  checksumType   = 'sha256'
  checksum64     = 'e99c1a63dbd03ef810f344dd2339557c609ba3d5a65f6b218c5cdaa98de85589'
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
