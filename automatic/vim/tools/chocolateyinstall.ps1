$ErrorActionPreference = 'Stop';
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$shortversion = '81'

. $toolsDir\helpers.ps1

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $toolsDir
  file           = "$toolsDir\gvim_8.1.2058_x86.zip"
  file64         = "$toolsDir\gvim_8.1.2058_x64.zip"
}

$pp = Get-PackageParameters
$installArgs = @{
  statement = Get-Statement $pp
  exeToRun  = "$toolsDir\vim\vim$shortversion\install.exe"
}

Write-Debug '$packageArgs'
Write-Debug $packageArgs
Write-Debug '$installArgs'
Write-Debug $installArgs

Install-ChocolateyZipPackage @packageArgs
Start-ChocolateyProcessAsAdmin @installArgs
Copy-Item "$toolsDir\vim\vim$shortversion\vimtutor.bat" $env:windir
Set-NoShim
