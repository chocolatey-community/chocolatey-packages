$ErrorActionPreference = 'Stop';
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$shortversion = '82'
$pp = Get-PackageParameters

. $toolsDir\helpers.ps1
$installDir = Get-InstallDir

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $installDir
  file          = "$toolsDir\gvim_8.2.0579_x86.zip"
  file64        = "$toolsDir\gvim_8.2.0579_x64.zip"
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
