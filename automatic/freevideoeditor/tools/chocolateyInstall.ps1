$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'freevideoeditor'
  fileType               = 'exe'
  url                    = 'http://downloads.videosoftdev.com/video_tools/video_editor.exe'
  checksum               = '9c7c8e3145bff1e3f239e39d1c419d90c374d6d4c1f8aab6ee59617d714eeae5'
  checksumType           = 'sha256'
  silentArgs             = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
  validExitCodes         = @(0)
  softwareName           = 'VSDC Free Video Editor*'
}
Install-ChocolateyPackage @packageArgs
