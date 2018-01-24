$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'freevideoeditor'
  fileType               = 'exe'
  url                    = 'http://downloads.videosoftdev.com/video_tools/video_editor.exe'
  checksum               = '95b60ecf5211c3a7ea1eafad5aa999d2fc20d0b5d2d85c63b26d22417085af20'
  checksumType           = 'sha256'
  silentArgs             = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
  validExitCodes         = @(0)
  softwareName           = 'VSDC Free Video Editor*'
}
Install-ChocolateyPackage @packageArgs
