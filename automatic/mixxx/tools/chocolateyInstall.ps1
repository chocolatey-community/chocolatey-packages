$ErrorActionPreference = 'Stop'

$packageName = 'mixxx'
$url32       = 'http://downloads.mixxx.org/mixxx-2.0.0/mixxx-2.0.0-win32.exe'
$url64       = 'http://downloads.mixxx.org/mixxx-2.0.0/mixxx-2.0.0-win64.exe'
$checksum32  = '3b7ad8078391b502341648f6fa4c7d094fd5eecb804f6f2789da6017bd766665'
$checksum64  = '200a1588cb59d5cb464e056166f4e79bbecfbcd133e6a2d11a974d4bf4a92628'

$packageArgs = @{
  packageName            = $packageName
  fileType               = 'EXE'
  url                    = $url32
  url64bit               = $url64
  checksum               = $checksum32
  checksum64             = $checksum64
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  registryUninstallerKey = $packageName
}
Install-ChocolateyPackage @packageArgs

$installLocation = Get-AppInstallLocation $packageArgs.registryUninstallerKey
if ($installLocation)  {
    Write-Host "$packageName installed to '$installLocation'"
}
else { Write-Warning "Can't find $PackageName install location" }
