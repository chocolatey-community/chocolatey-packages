$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'msi'
  file           = "$toolsPath\"
  file64         = "$toolsPath\"
  softwareName   = 'tightvnc*'
  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes = @(0, 2010, 1641)
}

Install-ChocolateyInstallPackage @packageArgs

# This reads the service start mode of 'TightVNC Server' and adapts it to the current value,
# otherwise it would always be set to 'Auto' on new installations, even if it was 'Manual'
# or 'disabled' before
$serviceStartMode = (Get-wmiobject win32_service -Filter "Name = 'tvnserver'").StartMode

if ($serviceStartMode -ne $null) {
  if ($serviceStartMode -ne 'Auto') {
    Start-ChocolateyProcessAsAdmin "Set-Service -Name tvnserver -StartupType $serviceStartMode"
  }
}

ls $toolsPath\*.msi | % { rm $_ -ea 0; if (Test-Path $_) { sc "$_.ignore" } }
