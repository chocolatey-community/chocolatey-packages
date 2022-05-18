$ErrorActionPreference = 'Stop';

$version = '12.12.4.1'

$packageArgs = @{
  packageName    = 'iTunes'
  fileType       = 'msi'
  url            = 'https://secure-appldnld.apple.com/itunes12/002-77762-20220517-49D7B771-6BD4-4A6D-B5D9-1C7C5FB0C154/iTunesSetup.exe'
  url64bit       = 'https://secure-appldnld.apple.com/itunes12/002-77761-20220517-E32CA53B-AE5E-4267-8B9B-1005C4BD94B9/iTunes64Setup.exe'
  softwareName   = 'iTunes'
  checksum       = '0739BB6C007A4A08DA8F3D5046FCBDE864546FD5B1F84C258BA532A9A1E5BDDA'
  checksumType   = 'sha256'
  checksum64     = 'd893492ebf63781293d6990116e940c8235a6cd201846622191a09abe6f0d0b4'
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
