$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'freevideoeditor'
  fileType               = 'exe'
  url                    = 'http://downloads.videosoftdev.com/video_tools/video_editor.exe'
  checksum               = '9d57351c9e5c5c76d596bc8733c832a48a91b8a121f328bef907344f971e616b'
  checksumType           = 'sha256'
  silentArgs             = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
  validExitCodes         = @(0)
  softwareName           = 'VSDC Free Video Editor*'
}
Install-ChocolateyPackage @packageArgs
