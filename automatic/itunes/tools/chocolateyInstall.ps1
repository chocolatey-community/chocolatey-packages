$ErrorActionPreference = 'Stop';

$version = '12.10.10.2'

$packageArgs = @{
  packageName    = 'iTunes'
  fileType       = 'msi'
  url            = 'https://secure-appldnld.apple.com/itunes12/001-50021-20201019-A1CAB6C2-1239-11EB-AE89-F95946985FC9/iTunesSetup.exe'
  url64bit       = 'https://secure-appldnld.apple.com/itunes12/001-50023-20201019-A1CA6082-1239-11EB-990E-FA5946985FC9/iTunes64Setup.exe'
  softwareName   = 'iTunes'
  checksum       = '99A5CE0367C1177C16131FE30CF9B2C45382917FEDBA88D02077E7C62BD2076D'
  checksumType   = 'sha256'
  checksum64     = '23a82361bfbbf4a2069839b8819e293d7a9fa25072333394887248a1f20acc01'
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
