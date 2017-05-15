$ErrorActionPreference = 'Stop';

$version = '12.6.1'

$packageArgs = @{
  packageName    = 'iTunes'
  fileType       = 'msi'
  url            = 'https://secure-appldnld.apple.com/itunes12/091-02141-20170515-85982C48-3662-11E7-8E72-49792DBC0DB3/iTunesSetup.exe'
  url64bit       = 'https://secure-appldnld.apple.com/itunes12/091-02135-20170515-85982C34-3662-11E7-8E72-48792DBC0DB3/iTunes64Setup.exe'
  softwareName   = 'iTunes'
  checksum       = 'bc882597e8dfbe33b203bb29afc175b5061af8ed6b5dbd8e72c0bb1abe887f85'
  checksumType   = 'sha256'
  checksum64     = '3e3e96ee5dcc12b10fb854ffbd8204596e022272de48ef31714ed33a4a2a1ede'
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
