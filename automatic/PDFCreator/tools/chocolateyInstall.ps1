$checksum = 'd2a96e30129706ef0603a30251973e01073bd1148c57a37258c4c78a95b56cca'
$url = 'http://orange.download.pdfforge.org/pdfcreator/2.5.0/PDFCreator-2_5_0-Setup.exe?file=AMIfv94Imo0ysrHIU1R0pTJm0p0bObBNxNjX4uT8t-wVM1Yi6X8_wG-yOiDKN9BdLOkU7N7SE-DReFcoBpz7EHyIlzN9Qny6RB9-gsFv7V9s8WwW_ew0PqVi5l0oNcpYqwOw5GCBSJyBG1YFbrmtN2S9ERdYFcauHP_X_N7Z06K1SWs2yODn64c&download'

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
