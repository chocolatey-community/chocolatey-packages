$packageName = 'PDFCreator'
$installerType = 'exe'
$baseInstallArgs = '/VERYSILENT /NORESTART'

try {

    $uninstallerPathLastPart = 'PDFCreator\unins000.exe'
    $uninstallerPath = Join-Path $env:ProgramFiles $uninstallerPathLastPart
    $uninstallerPathx86 = Join-Path ${env:ProgramFiles(x86)} $uninstallerPathLastPart

    if (Test-Path $uninstallerPathx86) {
        $uninstallerPath = $uninstallerPathx86
    }

    if (Test-Path $uninstallerPath) {
        Uninstall-ChocolateyPackage $packageName $installerType $baseInstallArgs $uninstallerPath
    }

} catch {
    Write-ChocolateyFailure $packageName $($_.Exception.Message)
    throw
}
