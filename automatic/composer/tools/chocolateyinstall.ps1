$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$fileName = 'Composer-Setup.6.2.0.exe'

$packageArgs = @{
  packageName  = 'composer'
  fileType     = 'exe'
  file         = Get-Item $toolsPath\$fileName
  checksum     = '1ED7DD2E67450705F0C1A1A2B8F8CB87DB29C36CA4CA8B2D2304864B8ECBB0E5'
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
