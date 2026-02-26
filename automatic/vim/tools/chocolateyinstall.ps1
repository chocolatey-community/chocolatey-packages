$ErrorActionPreference = 'Stop';
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$shortversion = '92'
$pp = Get-PackageParameters

. $toolsDir\helpers.ps1
$installDir = Get-InstallDir

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $installDir
  file          = "$toolsDir\gvim_9.2.0061_x86.zip"
  file64        = "$toolsDir\gvim_9.2.0061_x64.zip"
}

$installArgs = @{
  statement = Get-Statement
  exeToRun  = "$installDir\vim\vim$shortversion\install.exe"
}

'$installDir', ($installDir | Out-String), '$packageArgs', ($packageArgs | Out-String), '$installArgs', ($installArgs | Out-String) | ForEach-Object { Write-Debug $_ }

Get-ChocolateyUnzip @packageArgs | Write-Debug
Start-ChocolateyProcessAsAdmin @installArgs | Write-Debug
Set-Content -Path "$toolsDir\installDir" -Value $installDir
Create-SymbolicLink
