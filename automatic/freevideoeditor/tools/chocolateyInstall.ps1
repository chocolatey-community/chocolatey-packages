$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'freevideoeditor'
  fileType               = 'exe'
  url                    = 'http://downloads.videosoftdev.com/video_tools/video_editor.exe'
  checksum               = '3a0ace6cf7610b8489f8cbf56903ceea92929aa42ba3b2c1f0ce8092b99b3e6d'
  checksumType           = 'sha256'
  silentArgs             = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
  validExitCodes         = @(0)
  softwareName           = 'VSDC Free Video Editor*'
}
Install-ChocolateyPackage @packageArgs
