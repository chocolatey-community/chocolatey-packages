$ErrorActionPreference = 'Stop'
$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$filePath32 = "$toolsPath\Git-2.13.0-32-bit.exe"
$filePath64 = "$toolsPath\Git-2.13.0-64-bit.exe"
$installFile = if ((Get-ProcessorBits 64) -and $env:chocolateyForceX86 -ne 'true') {
                      Write-Host "Installing 64 bit version"; $filePath64 }
               else { Write-Host "Installing 32 bit version"; $filePath32 }

$pp = Get-PackageParameters
Set-InstallerRegistrySettings $pp

Stop-GitSSHAgent

$packageArgs = @{
    PackageName    = 'git.install'
    FileType       = 'exe'
    SoftwareName   = 'Git version *'
    File           = $installFile
    SilentArgs     = "/VERYSILENT", "/SUPPRESSMSGBOXES", "/NORESTART", "/NOCANCEL", "/SP-", "/LOG", (Get-InstallComponents $pp)
    ValidExitCodes = @(0)
}
Install-ChocolateyInstallPackage @packageArgs

$packageName = $packageArgs.packageName
$installLocation = Get-AppInstallLocation $packageArgs.SoftwareName
if (!$installLocation)  { Write-Warning "Can't find $packageName install location"; return }
Write-Host "$packageName installed to '$installLocation'"

$filePath32, $filepath64 | % { rm $_ -ea 0; if (Test-Path $_) { touch "$_.ignore" }}
