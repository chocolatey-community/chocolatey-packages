$ErrorActionPreference = 'Stop'

$toolsDir   = Split-Path -parent $MyInvocation.MyCommand.Definition
$fileName = 'tixati-3.24-1.install.exe'
$dlDir = "$Env:TEMP\chocolatey\$($Env:ChocolateyPackageName)\$($Env:ChocolateyPackageVersion)"

$packageArgs = @{
  packageName    = $Env:ChocolateyPackageName
  fileFullPath   = Join-path $dlDir $fileName
  url            = 'https://download1.tixati.com/download/tixati-3.24-1.win32-install.exe'
  url64bit       = 'https://download1.tixati.com/download/tixati-3.24-1.win64-install.exe'
  checksum       = '2d952934bdb5458ea76318a67cc9148c7c5d45979b91d4844050456af3ce9375'
  checksum64     = 'd09ad1cdc901461df96553ed876caa785b06b60cbb586eb4f50fa89c45ea615e'
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
