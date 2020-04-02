$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName   = 'cutepdf'
  fileType      = 'exe'
  url           = 'http://www.cutepdf.com/download/CuteWriter.exe'
  silentArgs    = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' # Inno Setup Package
  validExitCodes= @(0)
  softwareName  = 'cutepdf*'
  checksum      = '88490EB055EB1F594B30436CD299D5F0C1B425978128424EBF3D3124B6B9E42CC9E0E8FC556B1FA3589A1E76E4E23D99D4647DADA4EED0A0CE598C4357E8996A'
  checksumType  = 'sha512'
}

# Make sure Print Spooler service is up and running
try {
  $serviceName = 'Spooler'
  $spoolerService = Get-WmiObject -Class Win32_Service -Property StartMode,State -Filter "Name='$serviceName'"
  if ($spoolerService -eq $null) { throw "Service $serviceName was not found" }
  Write-Host "Print Spooler service state: $($spoolerService.StartMode) / $($spoolerService.State)"
  if ($spoolerService.StartMode -ne 'Auto' -or $spoolerService.State -ne 'Running') {
    Set-Service $serviceName -StartupType Automatic -Status Running
    Write-Host 'Print Spooler service new state: Auto / Running'
  }
} catch {
  Write-Warning "Unexpected error while checking Print Spooler service: $($_.Exception.Message)"
}

Install-ChocolateyPackage @packageArgs
