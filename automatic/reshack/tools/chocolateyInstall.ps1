$ErrorActionPreference = 'Stop'

$packageName = 'reshack'
$url32       = 'http://www.angusj.com/resourcehacker/reshacker_setup.exe'
$checksum32  = '2505464f8229c1eed63d0c7c316bf2777a4f670c825975bf03c0321fe783f894'

$packageArgs = @{
  packageName            = $packageName
  fileType               = 'EXE'
  url                    = $url32
  checksum               = $checksum32
  checksumType           = 'sha256'
  silentArgs             = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
  validExitCodes         = @(0)
  registryUninstallerKey = $packageName
}
Install-ChocolateyPackage @packageArgs
