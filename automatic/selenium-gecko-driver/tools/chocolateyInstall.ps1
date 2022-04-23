$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$toolsLocation = Get-ToolsLocation
$seleniumDir = "$toolsLocation\selenium"
$driverPath = "$seleniumDir\geckodriver.exe"

$parameters = Get-PackageParameters

$packageArgs = @{
  packageName    = 'selenium-gecko-driver'
  url            = 'https://github.com/mozilla/geckodriver/releases/download/v0.30.0/geckodriver-v0.30.0-win32.zip'
  checksum       = 'a41f33b9f3a97c27f229d86c9d07ce6320a2dbffad1eaa058fbd653c6938f5bffbe745031c422c49fd281650a2a189e1df2732c634aa6d3945fa55f14e43193c'
  checksumType   = 'sha512'
  url64bit       = 'https://github.com/mozilla/geckodriver/releases/download/v0.30.0/geckodriver-v0.30.0-win64.zip'
  checksum64     = 'ce73de3c8441fd68dcb819c20ad959decedebec94096c009bb6301de7982575012fed94f7ff902261fa88630475372d9e22e3c55872a7d9be228ee0d22d89646'
  checksumType64 = 'sha512'
  unzipLocation  = $seleniumDir
}

Install-ChocolateyZipPackage @packageArgs

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
