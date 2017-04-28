$ErrorActionPreference = 'Stop';

$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = 'secret-maryo-chronicles'
  fileType       = 'exe'
  file           = "$toolsPath\SMC_1.9_win32.exe"
  softwareName   = 'Secret Maryo Chronicles'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyInstallPackage @packageArgs

$packageArgs['file'] = "$toolsPath\SMC_Music_5.0_high_win32.exe"
$packageArgs['softwareName'] = 'Secret Maryo Chronicles Music Pack'
$packageArgs['packageName'] += '-background-music'

Install-ChocolateyInstallPackage @packageArgs

Remove-Item -Force -ea 0 "$toolsPath\*.exe","$toolsPath\*.ignore"
