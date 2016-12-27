$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'freevideoeditor'
  fileType               = 'exe'
  url                    = 'http://downloads.videosoftdev.com/video_tools/video_editor.exe'
  checksum               = '8b9e05110e0d75cae069d46e734d7dd885688ca7419313eb3cd525b11a70a121'
  checksumType           = 'sha256'
  silentArgs             = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
  validExitCodes         = @(0)
  softwareName           = 'VSDC Free Video Editor*'
}
Install-ChocolateyPackage @packageArgs
