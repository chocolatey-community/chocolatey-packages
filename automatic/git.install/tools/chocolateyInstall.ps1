$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$filePath32 = "$toolsPath\Git-2.11.0-32-bit.exe"
$filePath64 = "$toolsPath\Git-2.11.0-64-bit.exe"
$fileArgs = $(
    '/VERYSILENT /NORESTART /NOCANCEL /SP- ' +
    '/COMPONENTS="icons,icons\quicklaunch,ext,ext\shellhere,ext\guihere,assoc,assoc_sh" /LOG'
)

# Parse package parameters.
$pp = Get-PackageParameters

$installKey = Get-InstallKey
$installerArgs = @{
    InstallKey = $installKey
    GitOnlyOnPath = ($pp.GitOnlyOnPath -eq $true)
    WindowsTerminal = ($pp.WindowsTerminal -eq $true)
    GitAndUnixToolsOnPath = ($pp.GitAndUnixToolsOnPath -eq $true)
    NoAutoCrlf = ($pp.NoAutoCrlf -eq $true)
}
Set-InstallerSettings @installerArgs

# Make our install work properly when running under SYSTEM account (Chef Cliet Service, Puppet Service, etc).
$fileArgs = Remove-QuickLaunchForSystemUser -FileArgs $fileArgs

# Stop any running Git SSH agents.
Stop-GitSSHAgent

$installFile = if ((Get-ProcessorBits 64) -and $env:chocolateyForceX86 -ne 'true') {
  Write-Host "Installing 64 bit version"
  $filePath64
} else { 
  Write-Host "Installing 32 bit version"
  $filePath32
}

$packageArgs = @{
    PackageName = 'git.install'
    FileType = 'exe'
    SoftwareName = 'Git version*'
    File = $installFile
    SilentArgs = $fileArgs
    ValidExitCodes = @(0)
}

Install-ChocolateyInstallPackage @packageArgs

if (Test-Path $installKey) {
    $keyNames = Get-ItemProperty -Path $installKey

    if (!$pp.GitOnlyOnPath -and !$pp.GitAndUnixToolsOnPath) {
        $installLocation = $keyNames.InstallLocation
        if ($installLocation) {
            $gitPath = Join-Path $installLocation 'cmd'
            Install-ChocolateyPath $gitPath 'Machine'
        }
    }
}

# Lets remove the installer as there is no more need for it.
Remove-Item -Force $filePath32 -ea 0
Remove-Item -Force $filePath64 -ea 0