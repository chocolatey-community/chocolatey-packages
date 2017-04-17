$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$is64 = (Get-ProcessorBits 64) -and $env:chocolateyForceX86 -ne 'true'

$tcExeName = if ($is64) { 'totalcmd64.exe' } else { 'totalcmd.exe' }
$pp = Get-PackageParameters

$tcmdWork = Get-PackageCacheLocation
Extract-TCFiles
Set-TCParameters

$packageArgs = @{
    PackageName    = 'totalcommander'
    FileType       = 'exe'
    File           = "$tcmdWork\INSTALL.exe"
    File64         = "$tcmdWork\INSTALL.exe"
    SilentArgs     = ''
    ValidExitCodes = @(0)
    SoftwareName   = 'Total Commander*'
}
Install-ChocolateyInstallPackage @packageArgs
rm $toolsPath\*.exe, $toolsPath\*.zip -ea 0

$packageName = $packageArgs.packageName
$installLocation = Get-TCInstallLocation
if (!$installLocation)  { Write-Warning "Can't find $packageName install location"; return }
Write-Host "$packageName installed to '$installLocation'"

if ($pp.ShellExtension) { Set-TCShellExtension }
if ($pp.DefaultFM -eq $true) { Set-TCAsDefaultFM }
if ($pp.DefaultFM -like 'explorer*') { Set-ExplorerAsDefaultFM }
if ($pp.AddCommanderPath) { 
    Write-Host 'Adding system environment COMMANDER_PATH'
    Set-EnvironmentVariable 'COMMANDER_PATH' $installLocation Machine
}

Register-Application "$installLocation\$tcExeName" tc
Write-Host "$packageName registered as tc"
