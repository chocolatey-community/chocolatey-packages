$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$packageArgs64 = @{
  packageName = $env:ChocolateyPackageName
  file64      = "$toolsPath\BraveBrowserStandaloneSilentSetup.exe"
}

$packageArgs32 = @{
  packageName = $env:ChocolateyPackageName
  url                    = ''
  checksum               = ''
  checksumType           = 'sha256'
}

[version]$softwareVersion = '1.45.123'

Write-Host "Checking already installed version..."
$installedVersion = Get-InstalledVersion

if ($installedVersion -and ($softwareVersion -lt $installedVersion)) {
  Write-Warning "Skipping installation because a later version than $softwareVersion is installed."
}
elseif ($installedVersion -and ($softwareVersion -eq $installedVersion)) {
  Write-Warning "Skipping installation because version $softwareVersion is already installed."
}
else {
  if($env:PROCESSOR_ARCHITECTURE -eq "x86"){
    Install-ChocolateyPackage @packageArgs32
  }
  else {
    Install-ChocolateyInstallPackage @packageArgs64
  }


}

Remove-Item $toolsPath\*.exe -ea 0
