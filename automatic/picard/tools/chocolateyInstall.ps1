$ErrorActionPreference = 'Stop';

$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = 'picard'
  fileType       = 'exe'
  file           = "$toolsPath\picard_x32.exe"
  softwareName   = 'MusicBrainz Picard'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyInstallPackage @packageArgs
