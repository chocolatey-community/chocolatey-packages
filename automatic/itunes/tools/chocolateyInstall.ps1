$ErrorActionPreference = 'Stop';

$version = '12.13.3.2'

$packageArgs = @{
  packageName    = 'iTunes'
  fileType       = 'msi'
  url            = 'https://secure-appldnld.apple.com/itunes12/062-80277-20240911-F450712F-25C1-4F91-B94B-E3499323F2DE/iTunesSetup.exe'
  url64bit       = 'https://secure-appldnld.apple.com/itunes12/062-80279-20240911-EAAFAE4D-A09F-42A0-82B7-1C6BB9C635F6/iTunes64Setup.exe'
  softwareName   = 'iTunes'
  checksum       = 'DE72DBFAEAE29B77423795B304CC5B62C26FF79C29F16AEB058D51B5A410AEB4'
  checksumType   = 'sha256'
  checksum64     = '08f399888efd2ddb16147c28e893cf60c8c6a997f06e4fae89b14886cb5bdeb4'
  checksumType64 = 'sha256'
  silentArgs     = "/qn /norestart"
  validExitCodes = @(0, 2010, 1641, 3010)
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
