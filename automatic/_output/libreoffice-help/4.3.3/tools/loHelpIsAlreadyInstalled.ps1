function loHelpIsAlreadyInstalled {
  param([string]$keyName, [string]$version, [string]$language)

  $registryDirsArray = @('HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall', 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall')

  foreach ($registryDir in $registryDirsArray) {

    if (Test-Path $registryDir) {
      Get-ChildItem -Force -Path $registryDir | foreach {
        $currentKey = (Get-ItemProperty -Path $_.PsPath)
        if ($currentKey -match $keyName -and $currentKey -match $version) {
          if ($currentKey.Comments -match "LibreOffice [\d\.]+ Help Pack \($language\)") {
            return $currentKey
          }
        }
      }
    }
  }

  return $null
}
