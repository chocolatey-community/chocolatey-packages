$ErrorActionPreference = 'Stop'

$toolsDir   = Split-Path -parent $MyInvocation.MyCommand.Definition
$fileName = 'tixati-3.22-1.install.exe'
$dlDir = "$Env:TEMP\chocolatey\$($Env:ChocolateyPackageName)\$($Env:ChocolateyPackageVersion)"

$packageArgs = @{
  packageName    = $Env:ChocolateyPackageName
  fileFullPath   = Join-path $dlDir $fileName
  url            = 'https://download1.tixati.com/download/tixati-3.22-1.win32-install.exe'
  url64bit       = 'https://download1.tixati.com/download/tixati-3.22-1.win64-install.exe'
  checksum       = '92abcdb7218e81530924d585d8f829a0b148fd351851c603c56f117398f8d466'
  checksum64     = '3bcf3ac688a871f4acbeb3daf2b4a9d709618453f914fb314d02a44225dd3fa1'
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
