$ErrorActionPreference = 'Stop'

foreach ($name in 'onthespot-cli', 'onthespot-gui', 'onthespot-web') {
  Uninstall-BinFile -Name $name
}

$startMenuDir = Join-Path ([Environment]::GetFolderPath('CommonPrograms')) 'OnTheSpot'
if (Test-Path $startMenuDir) {
  Remove-Item -Path $startMenuDir -Recurse -Force
}

# The virtual environment and the managed Python interpreter live inside the
# package directory, which Chocolatey removes after this script has run.
