$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$toolsLocation = Get-ToolsLocation
$seleniumDir = "$toolsLocation\selenium"
$driverPath = "$seleniumDir\geckodriver.exe"

$parameters = Get-PackageParameters

$packageArgs = @{
  packageName  = 'selenium-gecko-driver'
  softwareName = "Gecko WebDriver"

  file         = "$toolsDir\geckodriver-v0.35.0-win32.zip"
  file64       = "$toolsDir\geckodriver-v0.35.0-win64.zip"
  destination  = $seleniumDir
}

Get-ChocolateyUnzip @packageArgs

Get-ChildItem $toolsDir\*.zip | ForEach-Object { Remove-Item $_ -ea 0 }

Uninstall-BinFile -Name 'geckodriver'
If ($parameters['SkipShim'] -ne 'true') {
  Install-BinFile -Name 'geckodriver' -Path $driverPath
}

$menuPrograms = [environment]::GetFolderPath([environment+specialfolder]::Programs)
$shortcutArgs = @{
  shortcutFilePath = "$menuPrograms\Selenium\Selenium Gecko Driver.lnk"
  targetPath       = $driverPath
  iconLocation     = "$toolsDir\icon.ico"
}

Install-ChocolateyShortcut @shortcutArgs
