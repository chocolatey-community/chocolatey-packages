$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  file           = "$toolsDir\peazip-6.5.0.WINDOWS.exe"
  file64         = "$toolsDir\peazip-6.5.0.WIN64.exe"
  fileType       = 'exe'
  packageName    = 'peazip'
  softwareName   = 'PeaZip'
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes = @(0, 1223)
}

Install-ChocolateyInstallPackage @packageArgs

Get-ChildItem $toolsDir\*.exe | % { rm $_ -ea 0; if (Test-Path $_) { sc "$_.ignore" } }
