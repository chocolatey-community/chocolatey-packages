$ErrorActionPreference = 'Stop';

$version = '12.10.4.2'

$packageArgs = @{
  packageName    = 'iTunes'
  fileType       = 'msi'
  url            = 'http://updates-http.cdn-apple.com/2020/windows/061-63192-20200127-45CC6584-412C-11EA-A7DF-092AB8D46CF0/iTunesSetup.exe'
  url64bit       = 'http://updates-http.cdn-apple.com/2020/windows/061-63189-20200127-45CC5012-412C-11EA-9F9C-0A2AB8D46CF0/iTunes64Setup.exe'
  softwareName   = 'iTunes'
  checksum       = '73F86B1C43C7DD9CB90E1CD944C0314F049D2BFFC5C58AAEC395B224D409FABE'
  checksumType   = 'sha256'
  checksum64     = '31db20bafca693e0af234a65563d8e8bc6584bdf574f69bc5998bab3d9c1c270'
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
