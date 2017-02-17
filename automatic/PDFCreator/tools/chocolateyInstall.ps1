$checksum = '9d650f48253c4cff23cb49a1a3626f26f43313c81f78dc8b1c771fde458e6e5d'
$url = 'http://orange.download.pdfforge.org/pdfcreator/2.5.1/PDFCreator-2_5_1-Setup.exe?file=AMIfv96uTRKHMoE1jDD0NrNd_FPXZ0tgOt1h6T41hh3Zt6__PsyOCdLEudIcX8fWeK-muSYUQVSSg3HrU_xmAZHHfmAd40Q8RTnO_OhLLljqfdeyRBFlUmMGZzgXCg6-OqY6DB4IKsH5yWP9Z7slBwhEcO0w-BwVyhh6EscTqeTExfK8ACYboII&download'

$installArgs = $('' +
  '/VERYSILENT /NORESTART ' +
  '/COMPONENTS="program,ghostscript,comsamples,' +
  'languages,languages\bosnian,languages\catalan,languages\catalan_valencia,' +
  'languages\chinese_simplified,languages\chinese_traditional,' +
  'languages\corsican,languages\croatian,languages\czech,languages\danish,' +
  'languages\dutch,languages\english,languages\estonian,languages\finnish,' +
  'languages\french,languages\galician,languages\german,languages\greek,' +
  'languages\hebrew,languages\hungarian,languages\italian,languages\irish,' +
  'languages\ligurian,languages\latvian,languages\lithuanian,' +
  'languages\norwegian_bokmal,languages\polish,languages\portuguese_br,' +
  'languages\romanian,languages\russian,languages\serbian_cyrillic,' +
  'languages\slovak,languages\slovenian,languages\spanish,' +
  'languages\swedish,languages\turkish,languages\valencian_avl"'
)

$packageArgs = @{
  packageName   = 'pdfcreator'
  unzipLocation = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
  fileType      = 'exe'
  url           = $url
  silentArgs    = $installArgs
  validExitCodes= @(0)
  softwareName  = 'pdfcreator*'
  checksum      = $checksum
  checksumType  = 'sha256'
}

# Make sure Print Spooler service is up and running
# this is required for both installing, and running pdfcreator
try {
  $serviceName = 'Spooler'
  $spoolerService = Get-WmiObject -Class Win32_Service -Property StartMode,State -Filter "Name='$serviceName'"
  if ($spoolerService -eq $null) { throw "Service $serviceName was not found" }
  Write-Host "Print Spooler service state: $($spoolerService.StartMode) / $($spoolerService.State)"
  if ($spoolerService.StartMode -ne 'Auto' -or $spoolerService.State -ne 'Running') {
    Set-Service $serviceName -StartupType Automatic -Status Running
    Write-Host "Print Spooler service new state: Auto / Running"
  }
} catch {
  Write-Warning "Unexpected error while checking Print Spooler service: $($_.Exception.Message)"
}

Install-ChocolateyPackage @packageArgs
