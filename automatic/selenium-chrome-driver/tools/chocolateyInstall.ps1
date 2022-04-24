Get-Process -Name chromedriver -ErrorAction SilentlyContinue | Stop-Process

$toolsDir = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"
$seleniumDir = "$(Get-ToolsLocation)\selenium"
$driverPath = "$seleniumDir\chromedriver.exe"

$parameters = Get-PackageParameters

$packageArgs = @{
  packageName   = 'selenium-chrome-driver'
  url           = 'https://chromedriver.storage.googleapis.com/83.0.4103.39/chromedriver_win32.zip'
  checksum      = '53c2e1f1b9f2a7571483284ea156958674501e8571cfe34be01282b4152e0770138d9aaef12876f109db9d77c1216362d0576aa40b4f19f039d4b97a15054c98'
  checksumType  = 'sha512'
  unzipLocation = $seleniumDir
}
Install-ChocolateyZipPackage @packageArgs

Uninstall-BinFile -Name 'chromedriver'
If ($parameters['SkipShim'] -ne 'true') {
  Install-BinFile -Name 'chromedriver' -Path $driverPath
}

$menuPrograms = [environment]::GetFolderPath([environment+specialfolder]::Programs)
$shortcutArgs = @{
  shortcutFilePath = "$menuPrograms\Selenium\Selenium Chrome Driver.lnk"
  targetPath       = $driverPath
  iconLocation     = "$toolsDir\icon.ico"
}
Install-ChocolateyShortcut @shortcutArgs
