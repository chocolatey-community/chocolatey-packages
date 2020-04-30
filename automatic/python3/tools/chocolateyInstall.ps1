$ErrorActionPreference = 'STOP'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$pp = Get-PackageParameters
$twoPartVersion = $Env:ChocolateyPackageVersion -replace "^(\d+\.\d+).*", "`$1"
$defaultFolder = '{0}\Python{1}' -f $Env:SystemDrive, ($twoPartVersion -replace '\.')
if ( $pp.InstallDir ) {
  $installDir = $pp.InstallDir
  if ($installDir.StartsWith("'") -or $installDir.StartsWith('"')) { $installDir = $installDir -replace '^.|.$' }
  mkdir -force $installDir -ea 0 | out-null
}
else {
  $installDir = $defaultFolder
}

$packageArgs = @{
  packageName    = 'python3'
  fileType       = 'exe'
  file           = "$toolsPath\python-3.8.3rc1.exe"
  file64         = "$toolsPath\python-3.8.3rc1-amd64.exe"
  silentArgs     = '/quiet InstallAllUsers=1 PrependPath=1 TargetDir="{0}"' -f $installDir
  validExitCodes = @(0)
  softwareName   = 'Python*'
}
Install-ChocolateyInstallPackage @packageArgs
Get-ChildItem $toolsPath\*.exe | ForEach-Object { Remove-Item $_ -ea 0; if (Test-Path $_) { Set-Content "$_.ignore" '' } }

. "$toolsPath/helpers.ps1"
$installLocation = Get-AppInstallLocation python | ForEach-Object { $_.TrimEnd('\') }

if (!$installLocation) {
  Update-SessionEnvironment
  $installLocation = Get-RegistryKeyValue -key "HKLM:\SOFTWARE\Python\PythonCore\$twoPartVersion\InstallPath" -subKey "(default)" | ForEach-Object { $_.TrimEnd('\') }
}
if ($installLocation -ne $installDir) {
  Write-Warning "Provided python InstallDir was ignored by the python installer"
  Write-Warning "Its probable that you had pre-existing python installation"
  Write-Warning "Installed to: $installLocation"
}
else { Write-Host "Installed to: '$installDir'" }

if (($Env:PYTHONHOME -ne $null) -and ($Env:PYTHONHOME -ne $InstallDir)) {
  Write-Warning "Environment variable PYTHONHOME points to different version: $Env:PYTHONHOME"
}

. "$toolsPath/helpers.ps1"
Protect-InstallFolder `
  -packageName $packageArgs["packageName"] `
  -defaultInstallPath $defaultFolder `
  -folder $installLocation
