$ErrorActionPreference = 'Stop'

$packageName = 'classic-shell'
$url32       = 'http://www.mediafire.com/download/dbbil746gavpirr/ClassicShellSetup_4_3_0.exe'
$url64       = $url32
$checksum32  = '4ee910b283871ab31ef03eeb15d9557e89b55eda8f0580340b4dd2fc90305ac8'
$checksum64  = $checksum32

$packageArgs = @{
  packageName            = $packageName
  fileType               = 'EXE'
  url                    = $url32
  url64bit               = $url64
  checksum               = $checksum32
  checksum64             = $checksum64
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/passive'
  validExitCodes         = @(0)
}
Install-ChocolateyPackage @packageArgs
