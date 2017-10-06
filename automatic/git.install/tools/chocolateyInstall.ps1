$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$pp = Get-PackageParameters
Set-InstallerRegistrySettings $pp

Stop-GitSSHAgent

$packageArgs = @{
    PackageName    = 'git.install'
    FileType       = 'exe'
    SoftwareName   = 'Git version *'
    File           = gi $toolsPath\*-32-bit.exe
    File64         = gi $toolsPath\*-64-bit.exe
    SilentArgs     = "/VERYSILENT", "/SUPPRESSMSGBOXES", "/NORESTART", "/NOCANCEL", "/SP-", "/LOG", (Get-InstallComponents $pp)
}
Install-ChocolateyInstallPackage @packageArgs

$packageName = $packageArgs.packageName
$installLocation = Get-AppInstallLocation $packageArgs.SoftwareName
if (!$installLocation)  { Write-Warning "Can't find $packageName install location"; return }
Write-Host "$packageName installed to '$installLocation'"

ls $toolsPath\*.exe | % { rm $_ -ea 0; if (Test-Path $_) { sc "$_.ignore" } }

if ($pp.NoCredentialManager) {
    Write-Host "Git credential manager will be disabled."
    Install-ChocolateyEnvironmentVariable GCM_VALIDATE 'false'
}