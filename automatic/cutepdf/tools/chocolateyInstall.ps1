$ErrorActionPreference = 'Stop'

$checksum = 'a3ed14ee41ec4d6300dd4e9eddd96e3dacf721d576b0b8c616718764e3682fbd'
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
