$ErrorActionPreference = 'Stop'

$packageName = 'tixati'
$fileName = 'tixati-2.62-1.install.exe'
$download_dir = "$Env:TEMP\chocolatey\$packageName\$Env:ChocolateyPackageVersion"

$packageArgs = @{
  packageName    = $packageName
  fileFullPath   = "$download_dir\$fileName"
  url            = 'https://download1.tixati.com/download/tixati-2.62-1.win32-install.exe'
  url64bit       = 'https://download1.tixati.com/download/tixati-2.62-1.win64-install.exe'
  checksum       = 'b6d05b7e6404b75974a3ed13466fd7ad963ad3eba6c8f591c1b3987a64100aa7'
  checksum64     = '4670205a6bcfdb40a2df4279506d7bcd594a1fd5402eae8bb48bd11a0cdaf04d'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
}
Get-ChocolateyWebFile @packageArgs

Write-Output "Running Autohotkey installer"
$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
Autohotkey.exe $toolsPath\$packageName.ahk $packageArgs.fileFullPath

$installLocation = Get-AppInstallLocation $packageName
if ($installLocation)  {
    Write-Host "$packageName installed to '$installLocation'"
    Register-Application "$installLocation\$packageName.exe"
    Write-Host "$packageName registered as $packageName"
}
else { Write-Warning "Can't find $PackageName install location" }
