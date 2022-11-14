$ErrorActionPreference = 'STOP'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. "$toolsPath/helpers.ps1"

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

Install-Python -toolsPath $toolsPath -installDir $installDir

if ($pp.InstallDir32) {
  Install-Python -toolsPath $toolsPath -installDir $pp.InstallDir32 -only32Bit

  $installed32BitLocation = Get-InstallLocation -twoPartVersion $twoPartVersion -is32Bit

  Write-Host "32-Bit Python installed to: '$installed32BitLocation'"
}

Get-ChildItem $toolsPath\*.exe | ForEach-Object { Remove-Item $_ -ea 0; if (Test-Path $_) { Set-Content "$_.ignore" '' } }

Update-SessionEnvironment
$installLocation = Get-InstallLocation -twoPartVersion $twoPartVersion

if ($installLocation -ne $installDir) {
  Write-Warning "Provided python InstallDir was ignored by the python installer"
  Write-Warning "Its probable that you had pre-existing python installation"
  Write-Warning "Python installed to: '$installLocation'"
}
else { Write-Host "Python installed to: '$installDir'" }

if (($Env:PYTHONHOME -ne $null) -and ($Env:PYTHONHOME -ne $InstallDir)) {
  Write-Warning "Environment variable PYTHONHOME points to different version: $Env:PYTHONHOME"
}

if ($pp.NoLockdown) {
  Write-Warning "NoLockdown parameter found. Not changing permissions. Please ensure your installation is secure."
} else {
  . "$toolsPath/helpers.ps1"
  Protect-InstallFolder `
    -packageName $env:ChocolateyPackageName `
    -defaultInstallPath $defaultFolder `
    -folder $installLocation  
}

