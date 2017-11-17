$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$fileName = if ((Get-ProcessorBits 64) -and ($env:chocolateyForceX86 -ne 'true')) {
  Write-Host "Installing 64 bit version" ; 'peazip-6.5.0.WIN64.exe' # 64-bit
} else {
  Write-Host "Installing 32 bit version" ; 'peazip-6.5.0.WINDOWS.exe' # 32-bit
}

$packageArgs = @{
  packageName    = 'peazip'
  fileType       = 'exe'
  softwareName   = 'PeaZip'
  file           = "$toolsDir\$fileName"
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes = @(0, 1223)
}

Install-ChocolateyInstallPackage @packageArgs

# Lets remove the installer as there is no more need for it
Remove-Item -Force "$toolsDir\*.exe","$toolsDir\*.exe.ignore" -ea 0
