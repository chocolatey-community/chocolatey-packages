$ErrorActionPreference = 'Stop';

$version = '12.12.6.1'

$packageArgs = @{
  packageName    = 'iTunes'
  fileType       = 'msi'
  url            = 'https://secure-appldnld.apple.com/itunes12/012-77814-20221020-E07F27CE-1FC6-4962-9F37-0F0A1608BC77/iTunesSetup.exe'
  url64bit       = 'https://secure-appldnld.apple.com/itunes12/012-77812-20221020-55E4CD5A-CF6C-48B4-A679-2ADF6587380D/iTunes64Setup.exe'
  softwareName   = 'iTunes'
  checksum       = 'BECD816DEB6E2A5D34F1CBFE16B9A160603E0A47D4D704D1DAA0662663000F8A'
  checksumType   = 'sha256'
  checksum64     = '122ebd72dac7d507ee68ff2ec20ba8322d95241db80a677a36f239931474dd7a'
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
