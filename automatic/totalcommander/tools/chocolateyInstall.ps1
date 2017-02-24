$ErrorActionPreference = 'Stop'

$is64 = if ((Get-ProcessorBits 64) -and $env:chocolateyForceX86 -ne 'true') {
               Write-Host "Installing 64 bit version"; $true  }
        else { Write-Host "Installing 32 bit version"; $false }

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$tcmdWork = Get-PackageCacheLocation
Extract-TCFiles
Set-TCParameters

$packageArgs = @{
    PackageName    = 'totalcommander'
    FileType       = 'exe'
    File           = "$tcmdWork\INSTALL.exe"
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

$tcExeName = if ($is64) { 'totalcmd64.exe' } else { 'totalcmd.exe' }
Register-Application "$installLocation\$tcExeName" tc
Write-Host "$packageName registered as tc"
