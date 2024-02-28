$ErrorActionPreference = 'Stop'

$toolsDir   = Split-Path -parent $MyInvocation.MyCommand.Definition
$fileName = 'tixati-3.21-1.install.exe'
$dlDir = "$Env:TEMP\chocolatey\$($Env:ChocolateyPackageName)\$($Env:ChocolateyPackageVersion)"

$packageArgs = @{
  packageName    = $Env:ChocolateyPackageName
  fileFullPath   = Join-path $dlDir $fileName
  url            = 'https://download1.tixati.com/download/tixati-3.21-1.win32-install.exe'
  url64bit       = 'https://download1.tixati.com/download/tixati-3.21-1.win64-install.exe'
  checksum       = 'bd2cac2445c6d23cc3ca536be1c2e26c68812b1e58b70f0a3b5d23346b66750f'
  checksum64     = 'a8022038c0e23576c76232ecbb5e7a8c6a51aa0f27370f8b7e394bbbabdd096e'
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
