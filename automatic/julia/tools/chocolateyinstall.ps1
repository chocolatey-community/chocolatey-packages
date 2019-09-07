$ErrorActionPreference = 'Stop';

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'exe'
  file          = "$toolsDir\julia-1.2.0-win32.exe"
  file64        = "$toolsDir\julia-1.2.0-win64.exe"

  softwareName  = 'Julia*'

  silentArgs    = '/S'
  validExitCodes= @(0)
}
$packageVersion = "1.2.0"

Install-ChocolateyInstallPackage @packageArgs

# Lets remove the installer as there is no more need for it
Get-ChildItem $toolsDir\*.exe | ForEach-Object { Remove-Item $_ -ea 0; if (Test-Path $_) { Set-Content "$_.ignore" '' } }

# Find the executable of current installed version
$executableLocation = $null
Get-UninstallRegistryKey -SoftwareName $packageArgs['softwareName'] | ForEach-Object {
  if(($_.DisplayName -split "\s+" | select -last 1) -eq $packageVersion) {
    $executableLocation = $_.DisplayIcon
    break
  }
}

if (!$executableLocation)  { Write-Warning "Can't find Julia install location"; return }
Write-Host "Julia installed to '$executableLocation'"

Install-BinFile 'julia' $executableLocation
