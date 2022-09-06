$ErrorActionPreference = 'Stop';
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$shortversion = '90'
$pp = Get-PackageParameters

. $toolsDir\helpers.ps1
$installDir = Get-InstallDir

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $installDir
  file          = "$toolsDir\gvim_9.0.0392_x86.zip"
  file64        = "$toolsDir\gvim_9.0.0392_x64.zip"
}

$installArgs = @{
  statement = Get-Statement
  exeToRun  = "$installDir\vim\vim$shortversion\install.exe"
}

'$installDir', ($installDir | Out-String), '$packageArgs', ($packageArgs | Out-String), '$installArgs', ($installArgs | Out-String) | ForEach-Object { Write-Debug $_ }

Install-ChocolateyZipPackage @packageArgs
Start-ChocolateyProcessAsAdmin @installArgs
Copy-Item -Path "$installDir\vim\vim$shortversion\vimtutor.bat" -Destination $env:windir
Set-Content -Path "$toolsDir\installDir" -Value $installDir
Create-SymbolicLink
