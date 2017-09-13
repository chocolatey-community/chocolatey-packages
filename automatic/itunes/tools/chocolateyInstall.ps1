$ErrorActionPreference = 'Stop';

$version = '12.7'

$packageArgs = @{
  packageName    = 'iTunes'
  fileType       = 'msi'
  url            = 'https://secure-appldnld.apple.com/itunes12/031-97720-20170912-DE538806-97F5-11E7-A892-1394FCD6B433/iTunesSetup.exe'
  url64bit       = 'https://secure-appldnld.apple.com/itunes12/031-97715-20170912-DE51D95C-97F5-11E7-8FE6-1494FCD6B433/iTunes64Setup.exe'
  softwareName   = 'iTunes'
  checksum       = '085f897859df345188d5f782e27711088822469db68a02585700ca02207a8383'
  checksumType   = 'sha256'
  checksum64     = '860bf23d7fd474e29bb3cb05433e85ac6702bc136ac17830965a3a02918cf087'
  checksumType64 = 'sha256'
  silentArgs     = "/qn /norestart"
  validExitCodes = @(0, 2010, 1641)
  unzipLocation  = Get-PackageCacheLocation
}

$app = Get-UninstallRegistryKey -SoftwareName $packageArgs.softwareName | select -first 1

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
