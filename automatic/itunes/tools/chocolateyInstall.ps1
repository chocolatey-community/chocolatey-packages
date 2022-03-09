$ErrorActionPreference = 'Stop';

$version = '12.12.3.5'

$packageArgs = @{
  packageName    = 'iTunes'
  fileType       = 'msi'
  url            = 'https://secure-appldnld.apple.com/itunes12/002-35074-20220304-184A304F-AAB1-4C24-BBA1-54CEB8BABADD/iTunesSetup.exe'
  url64bit       = 'https://secure-appldnld.apple.com/itunes12/002-35070-20220304-5521E72A-137B-4F09-9844-45BEBA5C3B40/iTunes64Setup.exe'
  softwareName   = 'iTunes'
  checksum       = '7719C33C77D0DBCB1E424D48DFBC52A12D06856B0BEB6E4B22D16055BB5A3A7C'
  checksumType   = 'sha256'
  checksum64     = '290b1049948d08a813392d437161ae4d44f4a7898d13d92c5e98ff02a21d8f7b'
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
