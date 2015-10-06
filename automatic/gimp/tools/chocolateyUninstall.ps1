$packageName = '{{PackageName}}'
$installerType = 'exe'
$installArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$gimpRegistryPath = $(
  'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\GIMP-2_is1'
)

if (Test-Path $gimpRegistryPath) {
  $uninstallString = (
    Get-ItemProperty -Path $gimpRegistryPath -Name 'UninstallString'
  ).UninstallString
}

if ($uninstallString) {
  Uninstall-ChocolateyPackage $packageName $installerType `
    $installArgs $uninstallString
}
