$packageName = 'pdfcreator'
$installerType = 'exe'
$baseInstallArgs = '/VERYSILENT /NORESTART'
$fullInstallArgs = $('' +
  $baseInstallArgs + ' ' +
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

$url = 'http://orange.download.pdfforge.org/pdfcreator/2.4.0/PDFCreator-2_4_0-Setup.exe?file=AMIfv97pmlXptiTqMp-BHVoAI8s-Cm7VHxjpiPsVcuGxVnMs4_45c2BsnRUFjdrYS688IX5WWKCgalXMZwLUYaaB3JL2yQFOc
C8Oqa1SzC3jXtG7uTkAbe9kIbxmkUDONXfgrLhlZPCeLOXyZxkZyI5uxoVDvvEZrNQpQ-jaolP7S4aOBoKBeHI&download'

$uninstallerPathLastPart = 'PDFCreator\unins000.exe'
$uninstallerPath = Join-Path $env:ProgramFiles $uninstallerPathLastPart

if (${env:ProgramFiles(x86)}) {
  $uninstallerPathx86 = Join-Path ${env:ProgramFiles(x86)} $uninstallerPathLastPart
  if (Test-Path $uninstallerPathx86) {
    $uninstallerPath = $uninstallerPathx86
  }
}

# Uninstall PDFCreator if older version is installed, otherwise the installation
# of the new version will fail.
if (Test-Path $uninstallerPath) {
  Uninstall-ChocolateyPackage $packageName $installerType $baseInstallArgs $uninstallerPath
}

$checksum = 'C6A05C5A0A3035881EE7E1C7C14F9A15850A2C955A69E2F353DA0DCABF4438FF'

Install-ChocolateyPackage $packageName $installerType $fullInstallArgs $url -checksum $checksum -checksumType 'SHA256'
