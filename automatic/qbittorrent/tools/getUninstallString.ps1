function getUninstallString($registryFolderName, $uninstallProperty) {

  $registryPaths = @(
    'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\',
    'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall'
  )

  foreach ($regPath in $registryPaths) {
    $appRegPath = Join-Path $regPath $registryFolderName
    if (Test-Path $appRegPath) {
      $key = Get-Item -LiteralPath $appRegPath
      $regString = $key.GetValue($uninstallProperty, $null)
      return $regString
    }
  }
}
