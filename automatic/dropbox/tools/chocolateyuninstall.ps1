. (Join-Path (Split-Path $MyInvocation.MyCommand.Definition -Parent) 'helpers.ps1')

$packageName = 'dropbox'
$fileType = 'exe'
$silentArgs = '/S'
$uninstallerPath = (getDropboxRegProps).UninstallString

if ($uninstallerPath) {
    Uninstall-ChocolateyPackage $packageName $fileType $silentArgs $uninstallerPath
}
