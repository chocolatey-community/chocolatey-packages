$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$pp = Get-PackageParameters

Stop-GitSSHAgent
# Workaround for chocolateyBeforeModify.ps1 being bypassed if upgrading via metapackage (chocolatey/choco#1092)
Stop-GitGPGAgent

$fileName32 = 'Git-2.37.3-32-bit.exe'
$fileName64 = 'Git-2.37.3-64-bit.exe'
$silentArgs = "/VERYSILENT", "/SUPPRESSMSGBOXES", "/NORESTART", "/NOCANCEL", "/SP-", "/LOG", (Get-InstallComponents $pp)
$silentArgs += Get-InstallOptions $pp

$packageArgs = @{
    PackageName    = 'git.install'
    FileType       = 'exe'
    SoftwareName   = 'Git'
    File           = Get-Item $toolsPath\$fileName32
    File64         = Get-Item $toolsPath\$fileName64
    SilentArgs     = $silentArgs
}
Install-ChocolateyInstallPackage @packageArgs
Get-ChildItem $toolsPath\$fileName32, $toolsPath\$fileName64 | ForEach-Object { Remove-Item $_ -ea 0; if (Test-Path $_) { Set-Content "$_.ignore" '' } }

$packageName = $packageArgs.packageName
$installLocation = Get-AppInstallLocation $packageArgs.SoftwareName
if (!$installLocation)  { Write-Warning "Can't find $packageName install location" }
else { Write-Host "$packageName installed to '$installLocation'" }

if ($pp.NoCredentialManager) {
    Write-Host "Git credential manager will be disabled."
    Install-ChocolateyEnvironmentVariable GCM_VALIDATE 'false'
}
