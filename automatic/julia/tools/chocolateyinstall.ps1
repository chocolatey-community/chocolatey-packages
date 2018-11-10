$ErrorActionPreference = 'Stop';

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'exe'
  file          = "$toolsDir\julia-1.0.2-win32.exe"
  file64        = "$toolsDir\julia-1.0.2-win64.exe"

  softwareName  = 'Julia*'

  silentArgs    = '/S'
  validExitCodes= @(0)
}

Install-ChocolateyInstallPackage @packageArgs

# Lets remove the installer as there is no more need for it
Get-ChildItem $toolsDir\*.exe | ForEach-Object { Remove-Item $_ -ea 0; if (Test-Path $_) { Set-Content "$_.ignore" '' } }

$installLocation = Get-AppInstallLocation $packageArgs.softwareName
if (!$installLocation)  { Write-Warning "Can't find Julia install location"; return }
Write-Host "Julia installed to '$installLocation'"

Install-BinFile 'julia' $installLocation\bin\julia.exe
