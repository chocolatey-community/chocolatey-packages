$ErrorActionPreference = 'Stop';

$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = 'scite4autohotkey'
  fileType       = 'exe'
  file           = "$toolsPath\s4ahk-install.exe"
  softwareName   = ''
  silentArgs     = ''
  validExitCodes = @(0)
}

# Experimental environment variable, but the best I know of for testing if '--notsilent' is used
if ($env:chocolateyInstallOverride -ne $true) {
  Start-Process "autohotkey" -Verb runas -ArgumentList "`"$toolsPath\install.ahk`""
}
Install-ChocolateyInstallPackage @packageArgs

Remove-Item -Force -ea 0 "$toolsPath\*.exe","$toolsPath\*.ignore"
