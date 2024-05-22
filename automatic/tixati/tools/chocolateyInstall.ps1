$ErrorActionPreference = 'Stop'

$toolsDir   = Split-Path -parent $MyInvocation.MyCommand.Definition
$fileName = 'tixati-3.25-1.install.exe'
$dlDir = "$Env:TEMP\chocolatey\$($Env:ChocolateyPackageName)\$($Env:ChocolateyPackageVersion)"

$packageArgs = @{
  packageName    = $Env:ChocolateyPackageName
  fileFullPath   = Join-path $dlDir $fileName
  url            = 'https://download1.tixati.com/download/tixati-3.25-1.win32-install.exe'
  url64bit       = 'https://download1.tixati.com/download/tixati-3.25-1.win64-install.exe'
  checksum       = 'a07614b9080f0efccebc4d2d288295d4745d6d1fa15b0b7e7220847823e071e9'
  checksum64     = '8fa816eb08b07f308ebf51592ae6863c818ddd72ef538336cb2a1ee0cb8f1c2c'
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
