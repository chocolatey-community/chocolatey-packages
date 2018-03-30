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
    file           = "$toolsPath\python-3.7.0b3.exe"
    file64         = "$toolsPath\python-3.7.0b3-amd64.exe"
    silentArgs     = '/quiet InstallAllUsers=1 PrependPath=1 TargetDir="{0}"' -f $installDir
    validExitCodes = @(0)
    softwareName   = 'Python*'
}
Install-ChocolateyInstallPackage @packageArgs
Get-ChildItem $toolsPath\*.exe | ForEach-Object { Remove-Item $_ -ea 0; if (Test-Path $_) { Set-Content "$_.ignore" }}

Write-Host "Installed to: '$installDir'"

if (($Env:PYTHONHOME -ne $null) -and ($Env:PYTHONHOME -ne $InstallDir)) {
    Write-Warning "Environment variable PYTHONHOME points to different version: $Env:PYTHONHOME"
}
