$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'gobby'
  fileType      = 'exe'
  softwareName  = "Gobby*"

  checksum      = '97c2eb92df2ba5322c04a13df62531583ea03609cd5eac3051490c5dc8a700e8'
  checksumType  = 'sha256'
  url           = 'http://releases.0x539.de/gobby/gobby-0.5.0.exe'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
