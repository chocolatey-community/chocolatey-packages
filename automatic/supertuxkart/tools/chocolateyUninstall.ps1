$ErrorActionPreference = 'Stop'

$packageName         = 'supertuxkart'

$installLocation = Get-AppInstallLocation $packageName
if (!$installLocation) {
    $installLocation = gp HKCU:\Software\SuperTuxKart -ea 0 | select -Expand '(default)'
    if (!$installLocation) { Write-Warning "Can't find install location"; return }
}

$packageArgs = @{
    packageName    = $packageName
    silentArgs     = "/S"
    fileType       = 'exe'
    validExitCodes = @(0)
    file           = "$installLocation\Uninstall.exe"
}

Write-Host "Using" $packageArgs.file
Uninstall-ChocolateyPackage @packageArgs
