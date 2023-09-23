$ErrorActionPreference = 'Stop';

$version = '12.12.10.1'

$packageArgs = @{
  packageName    = 'iTunes'
  fileType       = 'msi'
  url            = 'https://secure-appldnld.apple.com/itunes12/042-32486-20230911-150844F3-FE7A-4355-AA15-03182082D824/iTunesSetup.exe'
  url64bit       = 'https://secure-appldnld.apple.com/itunes12/042-32480-20230911-CC326CC1-E6C1-4F7C-A717-18493F59FE2E/iTunes64Setup.exe'
  softwareName   = 'iTunes'
  checksum       = '2B30F6045BA27488A97E1B45AA224A794527E9087877ADD93780A659F5024F65'
  checksumType   = 'sha256'
  checksum64     = '31465167704b2fd795aafc14cf5c04261d7c3ae663d087f63842e431aa204abc'
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
