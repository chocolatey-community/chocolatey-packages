$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$fileName = 'Composer-Setup.6.0.0.exe'

$packageArgs = @{
  packageName  = 'composer'
  fileType     = 'exe'
  file         = Get-Item $toolsPath\$fileName
  checksum     = '1B9C96E00CCBEEF5CA00A6C08765C9D5B0F94D7B37AE746441DF779D4B676809'
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
