$ErrorActionPreference = 'Stop'

$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$filePath = "$toolsPath\ClementineSetup-1.3.1.exe"
$packageName = 'clementine'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  file           = $filePath
  softwareName   = $packageName
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyInstallPackage @packageArgs
Remove-Item -Force -ea 0 $filePath,"$filePath.ignore"

$installLocation = Get-AppInstallLocation $packageArgs.softwareName
if ($installLocation) {
  Write-Host "$packageName installed to '$installLocation'"
  Register-Application "$installLocation\$packageName.exe"
  Write-Host "$packageName registered as $packageName"
} else {
  Write-Warning "Can't find $PackageName install location"
}
