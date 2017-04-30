$checksum = '9c2a3dd2df4c8857d70ec40a2d5c3df16d3826f4c800d40223e48a46ded669ed'
$url = 'http://orange.download.pdfforge.org/pdfcreator/2.5.2/PDFCreator-2_5_2-Setup.exe?file=AMIfv95WOv4ihUOqYzuDRNTF-BNisufzagdcUGbzl8VMd7isAqzuIYeT5Lp901ayUnBiHbLKBkvqzN9MdXwIOFjLgHIXPfiOdafqijOthBljySy9br9P-VIm8VAoQIsYYIJ9gR4ZD6PkDFrI_9wpAN2TKqO_GpxEEwoJ1DjdKOcEse6VBUlBL4I&download'

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
