$PSScriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Definition
Import-Module (Join-Path $PSScriptRoot 'functions.ps1')

try {

  $packageName = 'dropbox'
  $fileType = 'exe'
  $silentArgs = '/S'
  $uninstallerPath = (getDropboxRegProps).UninstallString

  if ($uninstallerPath) {
    Uninstall-ChocolateyPackage $packageName $fileType $silentArgs $uninstallerPath
  }

} catch {
  Write-ChocolateyFailure $packageName $($_.Exception.Message)
  throw
}

