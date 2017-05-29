$ErrorActionPreference = 'Stop'

$checksum = 'fed425b324ef6d7214fc4dba5109178ce58a568dab0afed39255e726e0992064'
$url = 'http://www.cutepdf.com/download/CuteWriter.exe'

$packageArgs = @{
  packageName   = 'cutepdf'
  fileType      = 'exe'
  url           = $url
  silentArgs    = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' # Inno Setup Package
  validExitCodes= @(0)
  softwareName  = 'cutepdf*'
  checksum      = $checksum
  checksumType  = 'sha256'
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
