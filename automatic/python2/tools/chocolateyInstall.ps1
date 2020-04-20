# This file should be identical for all python* packages
# https://docs.python.org/3/using/windows.html#installing-without-ui

$installDir  = '{0}\Python{1}' -f $Env:SystemDrive, ($Env:ChocolateyPackageVersion -replace '\.').Substring(0,2)
if ($Env:ChocolateyPackageParameters -match '/InstallDir:\s*(.+)') {
    $installDir = $Matches[1]
    if ($installDir.StartsWith("'") -or $installDir.StartsWith('"')){  $installDir = $installDir -replace '^.|.$' }
}
$installArgs  = '/qn /norestart ALLUSERS=1 ADDLOCAL=ALL TargetDir="{0}"' -f $installDir

$toolsPath = Split-Path -parent $MyInvocation.MyCommand.Definition

$params = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'msi'
  silentArgs     = $installArgs
  file           = "$toolsPath\python-2.7.18.msi"
  file64         = "$toolsPath\python-2.7.18.amd64.msi"
}

Install-ChocolateyInstallPackage @params
Write-Host "Installed to '$installDir'"

if (($Env:PYTHONHOME -ne $null) -and ($Env:PYTHONHOME -ne $InstallDir)) {
   Write-Warning "Environment variable PYTHONHOME points to different version: $Env:PYTHONHOME"
}

Write-Host "Adding $installDir to PATH if needed"
Install-ChocolateyPath $installDir 'Machine'

Get-ChildItem $toolsPath\*.msi | ForEach-Object { Remove-Item $_ -ea 0; if (Test-Path $_) { Set-Content "$_.ignore" } }
