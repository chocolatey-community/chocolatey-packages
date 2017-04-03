. (Join-Path (Split-Path $MyInvocation.MyCommand.Definition -Parent) 'helpers.ps1')

$packageName = 'dropbox'
$fileType = 'exe'
$silentArgs = '/S'
$uninstallerPath = (getDropboxRegProps).UninstallString

if ($uninstallerPath) {
    Uninstall-ChocolateyPackage $packageName $fileType $silentArgs $uninstallerPath
}

function getDropboxRegProps() {
  $uninstallRegistryPath = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\Dropbox'

  if (Test-Path $uninstallRegistryPath) {
    $props = @{
      "DisplayVersion" = (Get-ItemProperty $uninstallRegistryPath).DisplayVersion
      "UninstallString" = (Get-ItemProperty $uninstallRegistryPath).UninstallString
    }
  }

  return $props
}
