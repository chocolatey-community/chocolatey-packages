$ErrorActionPreference = 'Stop'

$toolsPath   = Split-Path $MyInvocation.MyCommand.Definition
$script_content = gc $toolsPath\install-script.js
if ((Get-ProcessorBits 64) -and $env:chocolateyForceX86 -ne 'true') {
  Write-Host "Setting 64 bit install"
  $script_content -replace '^\s+// (.+)//x64 install', '$1' | sc $toolsPath\install-script.js
} else { 
  Write-Host "Setting 32 bit install" 
  $script_content -replace '^\s+// (.+)//x32 install', '$1' | sc $toolsPath\install-script.js
}

$packageArgs = @{
  packageName            = 'nomacs'
  fileType               = 'exe'
  url                    = 'http://download.nomacs.org/nomacs-setup.exe'
  url64bit               = 'http://download.nomacs.org/nomacs-setup.exe'
  checksum               = 'd3d13450ddff8d368d844e1232f3df23858201cf795fbd742d2e3699cafdf1be'
  checksum64             = 'd3d13450ddff8d368d844e1232f3df23858201cf795fbd742d2e3699cafdf1be'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '--script "{0}\install-script.js" --proxy {1}' -f $toolsPath, (Get-EffectiveProxy)
  validExitCodes         = @(0)
  softwareName           = 'nomacs*'
}
Install-ChocolateyPackage @packageArgs
