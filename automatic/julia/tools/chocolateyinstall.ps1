$ErrorActionPreference = 'Stop';

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'exe'
  url           = 'https://julialang-s3.julialang.org/bin/winnt/x86/1.11/julia-1.11.7-win32.exe'
  checksum      = 'E046ED03D408080D81E7A775D43E4D4EF743E3E32993B5CE0D957E270A6A0209'
  checksumType  = 'sha256'
  file64        = "$toolsDir\julia-1.11.7-win64.exe"

  softwareName  = 'Julia*'

  silentArgs    = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes= @(0)
}
$packageVersion = "1.11.7"

if ((Get-OSArchitectureWidth -compare 32) -or ($env:chocolateyForceX86 -eq $true)) {
    Install-ChocolateyPackage @packageArgs
}
else {
    Install-ChocolateyInstallPackage @packageArgs
}

# Lets remove the installer as there is no more need for it
Get-ChildItem $toolsDir\*.exe | ForEach-Object { Remove-Item $_ -ea 0; if (Test-Path $_) { Set-Content "$_.ignore" '' } }

# Find the executable of current installed version
[array]$keysCurrentVersion = Get-UninstallRegistryKey -SoftwareName $packageArgs['softwareName'] | Where-Object {
  ($_.DisplayName -split "\s+" | Select-Object -last 1) -eq $packageVersion
}

if ($keysCurrentVersion.Count -eq 0)  { Write-Warning "Can't find Julia install location"; return }
$executableLocation = $($keysCurrentVersion | Select-Object -First 1).DisplayIcon
Write-Host "Julia installed to '$executableLocation'"

Install-BinFile 'julia' $executableLocation
