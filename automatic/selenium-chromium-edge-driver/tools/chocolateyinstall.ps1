$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$toolsLocation = Get-ToolsLocation
$seleniumDir = "$toolsLocation\selenium"
$driverPath = "$seleniumDir\msedgedriver.exe"

$parameters = Get-PackageParameters

$packageArgs = @{
  packageName    = 'selenium-chromium-edge-driver'
  url            = 'https://msedgedriver.microsoft.com/158.0.4370.33/edgedriver_win32.zip'
  url64          = 'https://msedgedriver.microsoft.com/158.0.4370.33/edgedriver_win64.zip'
  checksum       = '6e461eb12514df00982269d1a460e3dc594d6eebfcacf55dd1cd29830a1f221f'
  checksum64     = '4f4f28dfef2dd5a5560fd8863948ce4744f6c72a801d09e78283099c67b30324'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  unzipLocation  = $seleniumDir
}
Install-ChocolateyZipPackage @packageArgs

Uninstall-BinFile -Name 'msedgedriver'
If ($parameters['SkipShim'] -ne 'true') {
  Install-BinFile -Name 'msedgedriver' -Path $driverPath
}

$menuPrograms = [environment]::GetFolderPath([environment+specialfolder]::Programs)
$shortcutArgs = @{
  shortcutFilePath = "$menuPrograms\Selenium\Selenium Chromium Edge Driver.lnk"
  targetPath       = $driverPath
  iconLocation     = "$toolsDir\icon.ico"
}
Install-ChocolateyShortcut @shortcutArgs
