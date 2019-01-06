$ErrorActionPreference = 'Stop';

$version = '12.9.2.6'

$packageArgs = @{
  packageName    = 'iTunes'
  fileType       = 'msi'
  url            = 'https://secure-appldnld.apple.com/itunes12/041-17809-20181205-8DD4F85C-F720-11E8-B49B-E121828CC72D/iTunesSetup.exe'
  url64bit       = 'https://secure-appldnld.apple.com/itunes12/041-17808-20181205-8DD4E9E8-F720-11E8-BB37-E021828CC72D/iTunes64Setup.exe'
  softwareName   = 'iTunes'
  checksum       = '5769FC903338A1AD76607714F50503B171A6758E3CA8F0CD94B2505776142493'
  checksumType   = 'sha256'
  checksum64     = '87ee89d60c27fa2d1206bca0c48fb6d839302224f3d01cd66c1e6eb6115c5513'
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
