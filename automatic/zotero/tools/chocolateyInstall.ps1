$ErrorActionPreference = 'Stop'


$toolsPath = Split-Path -parent $MyInvocation.MyCommand.Definition
$File32Name = 'Zotero-7.0.13_win32_setup.exe'
$File64Name = 'Zotero-7.0.13_x64_setup.exe'

$File32Path = Join-Path $toolsPath $File32Name
$File64Path = Join-Path $toolsPath $File64Name

$packageArgs = @{
   packageName    = $env:ChocolateyPackageName
   softwareName   = "Zotero*"
   fileType       = 'exe'
   file           = "$File32Path"
   file64         = "$File64Path"
   silentArgs     = '/S'
   validExitCodes = @(0)
}

Install-ChocolateyInstallPackage @packageArgs

Remove-Item "$File32Path","$File64Path" -Force -ea 0
