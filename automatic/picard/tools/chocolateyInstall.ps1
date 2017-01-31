$ErrorActionPreference = 'Stop';

$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$filePath  = "$toolsPath\picard_x32.exe"

$packageArgs = @{
  packageName    = 'picard'
  fileType       = 'exe'
  file           = $filePath
  softwareName   = 'MusicBrainz Picard'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyInstallPackage @packageArgs

Remove-Item -Force -ea 0 $filePath,"$filePath.ignore"
