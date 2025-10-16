$ErrorActionPreference = 'Stop';

$version = '12.13.9.1'

$packageArgs = @{
  packageName    = 'iTunes'
  fileType       = 'msi'
  url            = 'https://secure-appldnld.apple.com/itunes12/093-86908-20251014-4D73F09D-8028-4EF8-B7D5-762F802B3161/iTunesSetup.exe'
  url64bit       = 'https://secure-appldnld.apple.com/itunes12/093-86906-20251014-EF746ED8-8BD0-4139-9834-5C6C716B6F9F/iTunes64Setup.exe'
  softwareName   = 'iTunes'
  checksum       = 'EE6BEF6379042F1F94B25E0106CFFB9D305ED01C784E1E82E57C805723AF2AFB'
  checksumType   = 'sha256'
  checksum64     = '8364987eed4d743f8072419af466d05351349a723af58b3acc7c830a7eee6210'
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
