$packageName = 'pdfcreator'
$installerType = 'exe'
$baseInstallArgs = '/VERYSILENT /NORESTART'

$uninstallerPathLastPart = 'PDFCreator\unins000.exe'
$uninstallerPath = Join-Path $env:ProgramFiles $uninstallerPathLastPart
$uninstallerPathx86 = Join-Path ${env:ProgramFiles(x86)} $uninstallerPathLastPart

if (Test-Path $uninstallerPathx86) {
  $uninstallerPath = $uninstallerPathx86
}

if (Test-Path $uninstallerPath) {
  Uninstall-ChocolateyPackage $packageName $installerType $baseInstallArgs $uninstallerPath
}
