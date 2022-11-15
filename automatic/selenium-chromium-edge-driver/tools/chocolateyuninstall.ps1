$ErrorActionPreference = 'Stop'

Uninstall-BinFile -Name 'msedgedriver'

$zipPackages = @(
  'edgedriver_win32.zip' # 32bit
  'edgedriver_win64.zip' # 64bit
)

$zipPackages | ForEach-Object {
  Uninstall-ChocolateyZipPackage -PackageName $env:ChocolateyPackageName -ZipFileName $_
}

$menuPrograms = [environment]::GetFolderPath([environment+specialfolder]::Programs)
$shortcutDir = "$menuPrograms\Selenium"

If (Test-Path -Path $shortcutDir) {
  $shortcutFile = "$shortcutDir\Selenium Chromium Edge Driver.lnk"
  If (Test-Path -Path $shortcutFile) {
    Remove-Item -Path $shortcutFile -Force
  }

  $directoryInfo = Get-ChildItem -Path $shortcutDir | Measure-Object
  If ($directoryInfo.count -eq 0) {
    Remove-Item -Path $shortcutDir -Force
  }
}
