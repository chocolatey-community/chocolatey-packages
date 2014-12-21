try {

  $scriptPath = Split-Path $script:MyInvocation.MyCommand.Path

  Import-Module (Join-Path $scriptPath 'getUninstallString.ps1')


  $uninstallString = getUninstallString 'qbittorrent' 'UninstallString'
  if ($uninstallString) {
    Uninstall-ChocolateyPackage $packageName 'exe' '/S' $uninstallString
  }

} catch {
  Write-ChocolateyFailure $packageName $($_.Exception.Message)
  throw
}
