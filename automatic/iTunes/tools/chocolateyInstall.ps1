$ErrorActionPreference = 'Stop';

$version = '12.5.5'

$packageArgs = @{
  packageName    = 'iTunes'
  fileType       = 'msi'
  url            = 'https://secure-appldnld.apple.com/itunes12/031-94942-20170123-014E4040-DF1D-11E6-8CA3-57D3D55B5B9D/iTunesSetup.exe'
  url64bit       = 'https://secure-appldnld.apple.com/itunes12/031-94939-20170123-014E4004-DF1D-11E6-8CA3-56D3D55B5B9D/iTunes6464Setup.exe'
  softwareName   = 'iTunes'
  checksum       = '2cd36679bd6c561b5bc7ce9555522f3d9599c4b4340c1310ff2cb47f76be584d'
  checksumType   = 'sha256'
  checksum64     = '46df29e6eef6eeb26afec49bb3428aea935eb4c8b4a79c8d1154b86ff3e02b51'
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
