$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$toolsLocation = Get-ToolsLocation
$seleniumDir = "$toolsLocation\selenium"
$driverPath = "$seleniumDir\msedgedriver.exe"

$parameters = Get-PackageParameters

$packageArgs = @{
  packageName    = 'selenium-chromium-edge-driver'
  url            = 'https://msedgedriver.microsoft.com/150.0.4078.65/edgedriver_win32.zip'
  url64          = 'https://msedgedriver.microsoft.com/150.0.4078.65/edgedriver_win64.zip'
  checksum       = '86aff8dcbadbd48abcdb4604006231ea94b716554cde13ea3bc0450e96caaf8a'
  checksum64     = 'c7435c9d62187f1a7a7d8eb0799a20923b6a6648be731ec8c78adbbdb239e772'
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
