$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$pp = Get-PackageParameters

$env:chocolateyInstallArguments = Get-TCInstallArgs
$env:chocolateyInstallOverride = 1
$packageArgs = @{
    PackageName    = 'totalcommander'
    FileType       = 'exe'
    File           = Get-Item $toolsPath\tc*.exe
    SilentArgs     = ""
    ValidExitCodes = @(0)
    SoftwareName   = 'Total Commander*'
}
Install-ChocolateyInstallPackage @packageArgs
Remove-Item $toolsPath\*.exe -ea 0

$packageName = $packageArgs.packageName
$installLocation = Get-TCInstallLocation
if (!$installLocation)  { Write-Warning "Can't find $packageName install location"; return }
Write-Host "$packageName installed to '$installLocation'"

Write-Host 'Setting system environment COMMANDER_PATH'
Set-EnvironmentVariable 'COMMANDER_PATH' $installLocation Machine

if ($pp.ShellExtension)              { Set-TCShellExtension }
if ($pp.DefaultFM -eq $true)         { Set-TCAsDefaultFM }
if ($pp.DefaultFM -like 'explorer*') { Set-ExplorerAsDefaultFM }

Register-Application "$installLocation\$tcExeName" tc
Write-Host "$packageName registered as tc"
