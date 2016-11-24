$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'free-virtual-keyboard'
  fileType               = 'exe'
  url                    = 'http://freevirtualkeyboard.com/FreeVKSetup.exe'
  checksum               = 'f5425f3d2ff11e8a0b98fc5fa652802a6e60b8c6361aa562002ea213d86d8aef'
  checksumType           = 'sha256'
  silentArgs             = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes         = @(0)
  softwareName           = 'Free Virtual Keyboard *'
}
Install-ChocolateyPackage @packageArgs

$packageName = $packageArgs.packageName
$installLocation = Get-AppInstallLocation 'FreeVK'
if ($installLocation)  {
    Write-Host "$packageName installed to '$installLocation'"
    Register-Application "$installLocation\freevk.exe" vk
    Write-Host "$packageName registered as vk"
} else { Write-Warning "Can't find $packageName install location" }

# Installer will start the process after installation, kill it
ps freevk -ea 0 | kill

