$seleniumDir = "$(Get-ToolsLocation)\selenium"

If (Test-Path -Path $seleniumDir) {
  $driverPath = "$seleniumDir\chromedriver.exe"
  If (Test-Path -Path $driverPath) {
    Remove-Item -Path $driverPath -Force
  }

  $directoryInfo = Get-ChildItem -Path $seleniumDir | Measure-Object
  If ($directoryInfo.count -eq 0) {
    Remove-Item -Path $seleniumDir -Force
  }
}

Uninstall-BinFile -Name 'chromedriver'

$menuPrograms = [environment]::GetFolderPath([environment+specialfolder]::Programs)
$shortcutDir = "$menuPrograms\Selenium"

If (Test-Path -Path $shortcutDir) {
  $shortcutFile = "$shortcutDir\Selenium Chrome Driver.lnk"
  If (Test-Path -Path $shortcutFile) {
    Remove-Item -Path $shortcutFile -Force
  }

  $directoryInfo = Get-ChildItem -Path $shortcutDir | Measure-Object
  If ($directoryInfo.count -eq 0) {
    Remove-Item -Path $shortcutDir -Force
  }
}
