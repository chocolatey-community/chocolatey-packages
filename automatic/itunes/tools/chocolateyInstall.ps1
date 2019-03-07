$ErrorActionPreference = 'Stop';

$version = '12.9.3.3'

$packageArgs = @{
  packageName    = 'iTunes'
  fileType       = 'msi'
  url            = 'https://secure-appldnld.apple.com/itunes12/041-31290-20190124-BBE902D6-D788-11E8-B555-8E91F34A5CAA/iTunesSetup.exe'
  url64bit       = 'https://secure-appldnld.apple.com/itunes12/041-31291-20190124-BBE902D6-D788-11E8-B555-8E91F34A5CAA/iTunes64Setup.exe'
  softwareName   = 'iTunes'
  checksum       = '26E775D83DBC9DB0D522EA487EB93F1E2A298924FA869B40C6129FE14582DF6B'
  checksumType   = 'sha256'
  checksum64     = '265cc69f9e05ce167f62c1735af302d50ca5291080244d496da7a8414df7ba2d'
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
