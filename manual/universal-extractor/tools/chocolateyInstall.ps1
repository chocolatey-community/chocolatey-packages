$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'universal-extractor'
  fileType               = 'exe'
  url                    = 'http://www.legroom.net/scripts/download.php?file=uniextract161'
  checksum               = '6df6a742c23eefa480cb37bad3835c5005801c61168d32610504eeb72c7b7f30'
  checksumType           = 'sha256'
  silentArgs             = '/VERYSILENT'
  validExitCodes         = @(0)
  softwareName           = 'Universal Extractor *'
}
Install-ChocolateyPackage @packageArgs

$packageName = $packageArgs.packageName
$installLocation = Get-AppInstallLocation $packageArgs.softwareName
if ($installLocation)  {
    Write-Host "$packageName installed to '$installLocation'"
    Register-Application "$installLocation\UniExtract.exe" unie
    Write-Host "$packageName registered as unie"
}
else { Write-Warning "Can't find $packageName install location" }
