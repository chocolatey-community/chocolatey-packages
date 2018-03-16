$ErrorActionPreference = 'Stop'

$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  PackageName   = 'pencil'
  FileFullPath  = Get-Item "$toolsPath\pencil.exe"
  Destination   = $toolsPath
  SoftwareName  = 'Pencil*'
  FileType      = 'EXE'
  SilentArgs    = '/S' # NSIS
  ValidExitCodes= @(0)
}
Install-ChocolateyPackage @packageArgs
