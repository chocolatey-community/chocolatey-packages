$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$toolsLocation = Get-ToolsLocation
$seleniumDir = "$toolsLocation\selenium"
$driverPath = "$seleniumDir\msedgedriver.exe"

$parameters = Get-PackageParameters

$packageArgs = @{
  packageName    = 'selenium-chromium-edge-driver'
  url            = 'https://msedgedriver.azureedge.net/134.0.3124.66/edgedriver_win32.zip'
  url64          = 'https://msedgedriver.azureedge.net/134.0.3124.66/edgedriver_win64.zip'
  checksum       = '3ea50ca7296628ea93af01e788e5eb1ef86efe06746820a59bdb9ed9cf0e0183'
  checksum64     = 'a4af9b9cbac9b12b5ea8698c4310d49f8a2bf361f302626594c4c3f0cbbf4833'
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
