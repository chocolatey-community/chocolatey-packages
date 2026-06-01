$ErrorActionPreference = 'Stop'

$packageName = $env:ChocolateyPackageName

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url            = 'http://freevirtualkeyboard.com/FreeVKSetup.exe'
  checksum       = 'aa235ca04acca23acfac40d6bfdb1c4e020e5ca3733019c1b69d67713e22e099'
  softwareName   = 'Free Virtual Keyboard'
  checksumType   = 'sha256'
  silentArgs     = "/VERYSILENT /NORESTART /SUPPRESSMSGBOXES /SP- /LOG=`"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).InnoInstall.log`""
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs

$installLocation = Get-AppInstallLocation $packageArgs.softwareName
if ($installLocation) {
  Write-Host "$packageName installed to '$installLocation'"
  $path = Get-ChildItem "$installLocation\*.exe" | Select-Object -First 1 -ExpandProperty FullName
  Register-Application $path -Name $packageName
  Write-Host "$packageName registered as $packageName"
} else {
  Write-Warning "Can't find $PackageName install location"
}

# Installer will start the process after installation, kill it
Get-Process freevk -ea 0 | Stop-Process
