$ErrorActionPreference = 'Stop'

$packageName = $env:ChocolateyPackageName

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url            = 'http://freevirtualkeyboard.com/FreeVKSetup.exe'
  checksum       = 'f5425f3d2ff11e8a0b98fc5fa652802a6e60b8c6361aa562002ea213d86d8aef'
  softwareName   = 'Free Virtual Keyboard'
  checksumType   = 'sha256'
  silentArgs     = "/VERYSILENT /NORESTART /SUPPRESSMSGBOXES /SP- /LOG=`"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).InnoInstall.log`""
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs

$installLocation = Get-AppInstallLocation $packageArgs.softwareName
if ($installLocation) {
  Write-Host "$packageName installed to '$installLocation'"
  $path = gci "$installLocation\*.exe" | select -First 1 -ExpandProperty FullName
  Register-Application $path -Name $packageName
  Write-Host "$packageName registered as $packageName"
} else {
  Write-Warning "Can't find $PackageName install location"
}

# Installer will start the process after installation, kill it
ps freevk -ea 0 | kill
