$ErrorActionPreference = 'Stop'

$packageName = 'classic-shell'
$url32       = 'http://classicshell.mediafire.com/file/d5llbbm8wu92jg8/ClassicShellSetup_4_3_1.exe'
$url64       = $url32
$checksum32  = '8bbd850fd8a2b41d090fbf8e005f9a5a76c774aca643318a8a34254f99f79ed8'
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
