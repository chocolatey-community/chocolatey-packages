$packageName = 'gimp'
$installerType = 'exe'
$installArgs = 'SP- /SILENT /NORESTART'
$gimpRegistryPath = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\GIMP-2_is1'


try {

  if (Test-Path $gimpRegistryPath) {
    $uninstallString = (Get-ItemProperty -Path $gimpRegistryPath -Name 'UninstallString').UninstallString
  }

  if ($uninstallString) {
    Uninstall-ChocolateyPackage $packageName $installerType $installArgs $uninstallString
  }

} catch {
  Write-ChocolateyFailure $packageName $($_.Exception.Message)
  throw
}
