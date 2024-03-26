$ErrorActionPreference = 'Stop'

if (Get-Process "Tixati*" -ErrorAction SilentlyContinue) {
   Throw "Tixati is running!  To prevent data loss, please fully quit Tixati before attempting to uninstall it."
}

$packageName     = 'tixati'
$installLocation = Get-AppInstallLocation $packageName
$uninstaller     = "$installLocation\uninstall.exe"
if (!(Test-Path $uninstaller)) { Write-Warning "$packageName has already been uninstalled by other means."; return }

$packageArgs = @{
    packageName            = $packageName
    silentArgs             = "/S"
    fileType               = 'EXE'
    validExitCodes         = @(0,10)
    file                   = $uninstaller
}
Uninstall-ChocolateyPackage @packageArgs
