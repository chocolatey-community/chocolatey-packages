$ErrorActionPreference = 'Stop'

$packageName = $env:ChocolateyPackageName

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url            = 'http://freevirtualkeyboard.com/FreeVKSetup.exe'
  checksum       = '97cf9bee8f4b9f963a2fbdfd649e8c08255503ebe3b94dfbb464f48a20ea7231'
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
