$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'activepresenter'
  fileType               = 'EXE'
  url                    = 'https://cdn.atomisystems.com/apdownloads/ActivePresenter_v6.0.3_setup.exe'
  checksum               = '4ffb6e600a255043e33fa59873ceb3ab263a71d481d3515ab5fbdc63a38e15db'
  checksumType           = 'sha256'
  silentArgs             = '/VERYSILENT'
  validExitCodes         = @(0)
  softwareName           = 'ActivePresenter'
}
Install-ChocolateyPackage @packageArgs
