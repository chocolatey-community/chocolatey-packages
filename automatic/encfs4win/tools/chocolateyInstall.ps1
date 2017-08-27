$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'encfs4win'
  fileType               = 'exe'
  url                    = 'https://github.com/jetwhiz/encfs4win/releases/download/v1.10.1-RC12/encfs-installer.exe'
  url64bit               = 'https://github.com/jetwhiz/encfs4win/releases/download/v1.10.1-RC10/encfs-installer.exe'
  checksum               = 'ee8e49acc8ae373c239f54694aba372ad00d886ce44c490dc36dab7f50fff7b3'
  checksum64             = '5967fd809d79f8c6c11da62e9d041a126e45865dc81cb7682be406741d459aaa'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'encfs4win*'
}
Install-ChocolateyPackage @packageArgs

$packageName = $packageArgs.packageName
$installLocation = Get-AppInstallLocation $packageName
if ($installLocation)  {
    Write-Host "$packageName installed to '$installLocation'"
    Register-Application "$installLocation\encfsw.exe"
    Write-Host "$packageName tray application registered as encfsw"
    Install-BinFile encfs "$installLocation\encfs.exe"

    Write-Host 'OS restart might be required'
}
else { Write-Warning "Can't find $PackageName install location" }
