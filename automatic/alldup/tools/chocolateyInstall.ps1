$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $Env:ChocolateyPackageName
  fileType       = 'EXE'
  file           = Join-Path -Path $toolsPath -ChildPath 'AllDupSetup.exe'
  silentArgs     = '/VERYSILENT /NORESTART /SUPPRESSMSGBOXES /SP- /LOG="{0}/InnoInstall.log"' -f (Get-PackageCacheLocation)
  softwareName   = 'AllDup*'
}

Install-ChocolateyInstallPackage @packageArgs

Get-ChildItem -Path (Join-Path -Path $toolsPath -ChildPath '*.exe') | ForEach-Object { Remove-Item -Path $_ -ErrorAction SilentlyContinue }

$packageName = $packageArgs.packageName
$installLocation = Get-AppInstallLocation -AppNamePattern "$packageName*"
if (-not $installLocation)  {
  Write-Warning "Can't find $packageName install location"
}
else {
  Write-Host "$packageName installed to '$installLocation'"

  Register-Application -ExePath (Join-Path -Path $installLocation -ChildPath "$packageName.exe")
  Write-Host "$packageName registered as $packageName"
}
