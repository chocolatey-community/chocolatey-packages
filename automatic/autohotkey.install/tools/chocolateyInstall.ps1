$ErrorActionPreference = 'Stop'

$silent = '/S'
if(Get-ProcessorBits 64) { $silent += ' /x64' }

$packageArgs = @{
  packageName    = 'autohotkey.install'
  fileType       = 'exe'
  url            = 'https://github.com/Lexikos/AutoHotkey_L/releases/download/v1.1.24.03/AutoHotkey_1.1.24.03_setup.exe'
  url64bit       = 'https://github.com/Lexikos/AutoHotkey_L/releases/download/v1.1.24.03/AutoHotkey_1.1.24.03_setup.exe'
  checksum       = '588ac27ea8a16e0512a28cd4f7560ae12d0b55500ef5abca92a3e95208319029'
  checksum64     = '588ac27ea8a16e0512a28cd4f7560ae12d0b55500ef5abca92a3e95208319029'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = $silent
  validExitCodes = @(0)
  softwareName   = 'autohotkey'
}
Install-ChocolateyPackage @packageArgs

$packageName = $packageArgs.packageName
$installLocation = Get-AppInstallLocation $packageArgs.softwareName
if ($installLocation)  {
    Write-Host "$packageName installed to '$installLocation'"
}
else {
    Write-Warning "Can't find $packageName install location"
}

