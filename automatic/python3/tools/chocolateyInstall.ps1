$ErrorActionPreference = 'STOP'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$pp = Get-PackageParameters
$installDir  = '{0}\Python{1}' -f $Env:SystemDrive, ($Env:ChocolateyPackageVersion -replace '\.').Substring(0,2)
if ( $pp.InstallDir ) {
    $installDir = $pp.InstallDir
    if ($installDir.StartsWith("'") -or $installDir.StartsWith('"')){  $installDir = $installDir -replace '^.|.$' }
    mkdir -force $installDir -ea 0 | out-null
}

$packageArgs = @{
    packageName    = 'python3'
    fileType       = 'exe'
    file           = gi $toolsPath\*_x32.???
    file64         = gi $toolsPath\*_x64.???
    silentArgs     = '/quiet InstallAllUsers=1 PrependPath=1 TargetDir="{0}"' -f $installDir
    validExitCodes = @(0)
    softwareName   = 'Python*'
}
Install-ChocolateyInstallPackage @packageArgs
ls $toolsPath\*.exe | % { rm $_ -ea 0; if (Test-Path $_) { sc "$_.ignore" }}

Write-Host "Installed to: '$installDir'"

if (($Env:PYTHONHOME -ne $null) -and ($Env:PYTHONHOME -ne $InstallDir)) {
    Write-Warning "Environment variable PYTHONHOME points to different version: $Env:PYTHONHOME"
}
