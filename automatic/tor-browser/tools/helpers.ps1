function GetInstallDirectory() {
  param($toolsPath)

  $pp = Get-PackageParameters
  if ($pp.InstallDir) { return $pp.InstallDir }

  $binRoot = Get-ToolsLocation
  $destinationFolder = Join-Path $binRoot "tor-browser"

  if (!(Test-Path $destinationFolder)) {
    $destinationFolder = Join-Path $toolsPath "tor-browser"
  } else {
    Write-Warning @(
      'Deprecated installation folder detected (binRoot). ' +
      'This package will continue to install tor-browser there ' +
      'unless you manually remove it from "' + $destinationFolder + '".'
    )
  }

  $desktopPath = [System.Environment]::GetFolderPath('Desktop')
  $oldDestinationFolder = Join-Path $desktopPath 'Tor-Browser'
  if ((Test-Path $oldDestinationFolder) -and
      ($oldDestinationFolder -ne $destinationFolder)) {
    $destinationFolder = $oldDestinationFolder

    Write-Warning @(
      'Deprecated installation fodler detected: Desktop/Tor-Browser. ' +
      'This package will continue to install tor-browser there unless you ' +
      'remove the deprecated installation folder. After your did that, reinstall ' +
      'this package again with the "--force" parameter. Then it will be installed ' +
      'to the package tools directory.'
    )
  }

  return $destinationFolder
}
