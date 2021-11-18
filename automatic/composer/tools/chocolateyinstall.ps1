$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$fileName = 'Composer-Setup.6.3.0.exe'

$packageArgs = @{
  packageName  = 'composer'
  fileType     = 'exe'
  file         = Get-Item $toolsPath\$fileName
  checksum     = '10826B503BA6823F14893F0627823017EE1778881222EA9960A7E268739D6956'
  checksumType = 'sha256'
  silentArgs   = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
  softwareName = 'composer*'
}

try {
  Install-ChocolateyInstallPackage @packageArgs
  Get-ChildItem $toolsPath\*.exe | ForEach-Object { Remove-Item $_ -ea 0; if (Test-Path $_) { Set-Content "$_.ignore" '' } }
}
catch {

  if ($env:ChocolateyExitCode -eq '1') {
    Write-Host ""
    Write-Host "*** IMPORTANT ***"
    Write-Host "The installation failed. Your PHP or other settings are incorrect."
    Write-Host "  Use the --notsilent option to run the installer interactively."
    Write-Host ""
  }
}
