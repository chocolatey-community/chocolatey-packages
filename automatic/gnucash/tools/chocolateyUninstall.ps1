$packageName = '{{PackageName}}'
$fileType = 'exe'
$silentArgs = '/SILENT'

$registryPath32 = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\GnuCash_is1'
$registryPathWow6432 = 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\GnuCash_is1'

if (Test-Path $registryPath32) {
  $registryPath = $registryPath32
}

if (Test-Path $registryPathWow6432) {
  $registryPath = $registryPathWow6432
}

if ($registryPath) {
  $uninstallString = (Get-ItemProperty -Path $registryPath -Name 'UninstallString').UninstallString
}

if ($uninstallString) {
  Uninstall-ChocolateyPackage $packageName $fileType $silentArgs $uninstallString
}
