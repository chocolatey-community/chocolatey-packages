$ErrorActionPreference = 'Stop';

$version = '12.10.1.4'

$packageArgs = @{
  packageName    = 'iTunes'
  fileType       = 'msi'
  url            = 'http://updates-http.cdn-apple.com/2019/windows/061-27906-20191004-E74901A4-E6F7-11E9-979F-9DA916B72188/iTunesSetup.exe'
  url64bit       = 'http://updates-http.cdn-apple.com/2019/windows/061-27904-20191004-E748B8A2-E6F7-11E9-8931-E55C44AC54BE/iTunes64Setup.exe'
  softwareName   = 'iTunes'
  checksum       = 'C550F65F67E399ABB6AB794242885FFDA69F71342B4530023DA5A9F81B4AB6AA'
  checksumType   = 'sha256'
  checksum64     = '253d2fd290d2cbd7d12ded916ed4af9d62bdce807ad85cca131b4875c057c373'
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
