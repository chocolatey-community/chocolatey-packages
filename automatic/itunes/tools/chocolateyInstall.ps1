$ErrorActionPreference = 'Stop';

$version = '12.10.7.3'

$packageArgs = @{
  packageName    = 'iTunes'
  fileType       = 'msi'
  url            = 'https://secure-appldnld.apple.com/itunes12/001-09465-20200521-4DFBCF32-9B87-11EA-9C46-7249566C00C0/iTunesSetup.exe'
  url64bit       = 'https://secure-appldnld.apple.com/itunes12/001-09461-20200521-4DFB20C8-9B87-11EA-8595-7349566C00C0/iTunes64Setup.exe'
  softwareName   = 'iTunes'
  checksum       = '98F94CC2D969D73A3002F00CD987593928398CC9306D2EE2CA1AB5ADE6FDF7C1'
  checksumType   = 'sha256'
  checksum64     = '0a4ec75f0ad0589fecc95b7ba7e3264c4da83d1bf06fcb17f9aa6d15cc6d40d6'
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
