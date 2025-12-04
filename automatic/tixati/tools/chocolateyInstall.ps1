$ErrorActionPreference = 'Stop'

if (Get-Process "Tixati*" -ErrorAction SilentlyContinue) {
   Throw "Tixati is running!  To prevent data loss, please fully quit Tixati before attempting to upgrade it."
}

$toolsDir   = Split-Path -parent $MyInvocation.MyCommand.Definition
$fileName = 'tixati-3.41-1.install.exe'
$dlDir = "$Env:TEMP\chocolatey\$($Env:ChocolateyPackageName)\$($Env:ChocolateyPackageVersion)"

$packageArgs = @{
  packageName    = $Env:ChocolateyPackageName
  fileFullPath   = Join-path $dlDir $fileName
  url            = 'https://download.tixati.com/tixati-3.41-1.win32-install.exe'
  url64bit       = 'https://download.tixati.com/tixati-3.41-1.win64-install.exe'
  checksum       = '17fccf56462ea59481ed4c1734446f68050d9edcb5304beff84a50c19d5c360d'
  checksum64     = 'a1174ea32594bb076761e6ae411841b0f9296c9b53232183671ee7cd02a7f5b2'
  checksumType   = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

# silent install requires AutoHotKey
$ahkFile = Join-Path $toolsDir "$($Env:ChocolateyPackageName).ahk"
$ahkProc = Start-Process -FilePath AutoHotkey.exe -ArgumentList "$ahkFile" -PassThru
Write-Debug "AutoHotKey start time:`t$($ahkProc.StartTime.ToShortTimeString())"
Write-Debug "AutoHotKey Process ID:`t$($ahkProc.Id)"

Start-ChocolateyProcessAsAdmin -ExeToRun $packageArgs.fileFullPath

$installLocation = Get-AppInstallLocation $Env:ChocolateyPackageName
if ($installLocation) {
    Write-Host "$($Env:ChocolateyPackageName) installed to '$installLocation'"
    Register-Application "$installLocation\$($Env:ChocolateyPackageName).exe"
    Write-Host "$($Env:ChocolateyPackageName) registered as $($Env:ChocolateyPackageName)"
}
else { 
  Write-Warning "Can't find $($Env:ChocolateyPackageName) install location"
}
