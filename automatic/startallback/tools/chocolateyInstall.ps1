$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'startallback'
  fileType               = 'exe'
  url                    = 'https://startisback.sfo3.cdn.digitaloceanspaces.com/StartAllBack_3.6.4_setup.exe'
  checksum               = '6788c0888e39e6883e12ab6f7e9c481a701aae98a21daa406466f52f03a199d2'
  checksumType           = 'sha256'
  silentArgs             = '/silent'
  validExitCodes         = @(0)
  softwareName           = 'startallback*'
}
Install-ChocolateyPackage @packageArgs

$packageName = $packageArgs.packageName
$installLocation = Get-AppInstallLocation $packageName
if (!$installLocation)  { Write-Warning "Can't find $packageName install location"; return }
Write-Host "$packageName installed to '$installLocation'"
