$ErrorActionPreference = 'Stop'

$toolsPath   = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName            = 'nomacs'
  fileType               = 'msi'
  url                    = 'http://download.nomacs.org/nomacs-setup-x64.msi'
  url64bit               = 'http://download.nomacs.org/nomacs-setup-x64.msi'
  checksum               = '82d3e5f69dc9affed5b1385952535f3af3e4b2de665a81a850468d647886736b'
  checksum64             = '82d3e5f69dc9affed5b1385952535f3af3e4b2de665a81a850468d647886736b'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/quiet /norestart /log "{0}/setup.log"' -f (Get-PackageCacheLocation)
  validExitCodes         = @(0)
  softwareName           = 'nomacs*'
}
Install-ChocolateyPackage @packageArgs

# $script_content = gc $toolsPath\install-script.js
# if ((Get-ProcessorBits 64) -and $env:chocolateyForceX86 -ne 'true') {
#   Write-Host "Setting 64 bit install"
#   $script_content -replace '^\s+// (.+)//x64 install', '$1' | sc $toolsPath\install-script.js
# } else { 
#   Write-Host "Setting 32 bit install" 
#   $script_content -replace '^\s+// (.+)//x32 install', '$1' | sc $toolsPath\install-script.js
# }

# '--script "{0}\install-script.js" --proxy {1}' -f $toolsPath, (Get-EffectiveProxy)