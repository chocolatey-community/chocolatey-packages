$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$toolsLocation = Get-ToolsLocation
$seleniumDir = "$toolsLocation\selenium"
$driverPath = "$seleniumDir\msedgedriver.exe"

$parameters = Get-PackageParameters

$packageArgs = @{
  packageName    = 'selenium-chromium-edge-driver'
  url            = 'https://msedgedriver.azureedge.net/137.0.3296.83/edgedriver_win32.zip'
  url64          = 'https://msedgedriver.azureedge.net/137.0.3296.83/edgedriver_win64.zip'
  checksum       = '4912302161a61b2852919176e1b3b1cc408351fe32d5c1a542e7b04e2c8d4e0b'
  checksum64     = '736900ebed11a70d1f31a32bbb5cdf84d3a80a610a034c50748484a769c89483'
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
