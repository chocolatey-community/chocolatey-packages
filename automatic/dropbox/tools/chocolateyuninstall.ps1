. (Join-Path (Split-Path $MyInvocation.MyCommand.Definition -Parent) 'helpers.ps1')

$packageName = 'dropbox'
$fileType = 'exe'
$silentArgs = '/S'
$uninstallProps = getDropboxRegProps

if ($uninstallProps -and $uninstallProps.UninstallString) {
    Uninstall-ChocolateyPackage $packageName $fileType $silentArgs $uninstallerPath.UninstallString
}
