$checksum = '56d0574d50377fb1cd310809e60890c7af195966a7cb2ea77eceb29fd8d15353'
$url = 'http://orange.download.pdfforge.org/pdfcreator/2.4.1/PDFCreator-2_4_1-Setup.exe?file=AMIfv952CMgc-tsOw-5AYXO4wDSYHiuDSSCWbOwf0R90_cSW0ZgaMZH5wkVd3X6dmpijubHE1PE3UlmoZ9pD3y07xGA_5jYz7un9OD1P_g31ESP_6-xi3xsWKgXAl5aG2vHhMFgrrQbm3ogxSjUcqABDpUpqbaXNfWzhNE2wbQnyFmyGMfUATxs&download'

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

Install-ChocolateyPackage @packageArgs
