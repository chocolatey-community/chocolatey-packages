$ErrorActionPreference = 'Stop';

$version = '12.7.1'

$packageArgs = @{
  packageName    = 'iTunes'
  fileType       = 'msi'
  url            = 'https://secure-appldnld.apple.com/itunes12/091-30743-20171030-2E974C8C-B9B4-11E7-A0B9-71E6DF1CD815/iTunesSetup.exe'
  url64bit       = 'https://secure-appldnld.apple.com/itunes12/091-30751-20171030-2E96FF02-B9B4-11E7-81C5-9CE3DF1CD815/iTunes64Setup.exe'
  softwareName   = 'iTunes'
  checksum       = '6d4e2f72d80420c0561fa8780dc7444ac7497f857ed0a413917b47776ba0aef0'
  checksumType   = 'sha256'
  checksum64     = '8708406ebf6d8250d1979141adff14e7fe656c90c91e61107baae64af623b4eb'
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
