$packageName = 'gnucash'
$version = '2.6.5'
$fileType = 'exe'
$silentArgs = '/SILENT'
# \{\{DownloadUrlx64\}\} is the required variable here (it’s not a typo)
$url = "http://downloads.sourceforge.net/sourceforge/gnucash/gnucash-2.6.5-setup.exe"

$registryPath32 = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\GnuCash_is1'
$registryPathWow6432 = 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\GnuCash_is1'

try {

  if (Test-Path $registryPath32) {
    $registryPath = $registryPath32
  }

  if (Test-Path $registryPathWow6432) {
    $registryPath = $registryPathWow6432
  }

  if ($registryPath) {
    $displayName = (Get-ItemProperty -Path $registryPath -Name 'DisplayName').DisplayName
    $installedVersion = $displayName -replace '.+?([\d\.]+)', '$1'
  }

  if ($version -eq $installedVersion) {
    Write-Output "GnuCash $installedVersion is already installed. Skipping download and installation."
  } else {
    Install-ChocolateyPackage $packageName $fileType $silentArgs $url
  }

} catch {
  Write-ChocolateyFailure $packageName $($_.Exception.Message)
  throw
}
