$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$toolsLocation = Get-ToolsLocation
$seleniumDir = "$toolsLocation\selenium"
$driverPath = "$seleniumDir\msedgedriver.exe"

$parameters = Get-PackageParameters

$packageArgs = @{
  packageName    = 'selenium-chromium-edge-driver'
  url            = 'https://msedgedriver.azureedge.net/111.0.1661.44/edgedriver_win32.zip'
  url64          = 'https://msedgedriver.azureedge.net/111.0.1661.44/edgedriver_win64.zip'
  checksum       = '349d0b8787150a9e95a049e26c3669ec5daf9bc315c92acffc6a3d0cf85c16e6'
  checksum64     = 'e202a3979a8758f1750cd0de59274e19836d0ab06a876d9ed054a6d5d378b185'
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
