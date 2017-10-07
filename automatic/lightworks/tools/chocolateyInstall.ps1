$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'lightworks'
  fileType               = 'EXE'
  url                    = 'https://s3.amazonaws.com/lightworks/lightworks_v14.0.0_full_32bit_setup.exe'
  url64bit               = 'https://s3.amazonaws.com/lightworks/lightworks_v14.0.0_full_64bit_setup.exe'
  checksum               = '4b7a1dd5033bf8501eda63e877d3e498dbbb9c4cd86031690b386da6370c658a'
  checksum64             = '86c7f33d569e2fa1f3151c9856706008a40806501bb13a335aaea751c45ecae6'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'Lightworks'
}
Install-ChocolateyPackage @packageArgs

$packageName = $packageArgs.packageName
$installLocation = Get-AppInstallLocation $packageArgs.softwareName
if ($installLocation)  {
    Write-Host "$packageName installed to '$installLocation'"
    Register-Application "$installLocation\$packageName.exe"
    Write-Host "$packageName registered as $packageName"
}
else { Write-Warning "Can't find $PackageName install location" }
