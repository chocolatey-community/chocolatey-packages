$checksum = '2D9E07F25358C9D2317BC639AFCDEDDB893D1FCFD43BB66FF372DBA11E169EE1'

$packageArgs = @{
  packageName   = 'cutepdf'
  unzipLocation = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
  fileType      = 'exe'
  url           = 'http://www.cutepdf.com/download/CuteWriter.exe'
  silentArgs    = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' # Inno Setup Package
  validExitCodes= @(0)
  softwareName  = 'cutepdf*'
  checksum      = $checksum
  checksumType  = 'sha256'
}

Install-ChocolateyPackage @packageArgs
