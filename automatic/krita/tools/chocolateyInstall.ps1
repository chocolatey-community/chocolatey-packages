$toolsDir = Split-Path $MyInvocation.MyCommand.Definition
$is64 = (Get-OSArchitectureWidth 64) -and $env:chocolateyForceX86 -ne 'true'

if (!$is64) {
  throw '32bit Versions of Krita is no longer supported, please install version 4.4.3 or lower.'
}

$packageArgs = @{
  packageName  = 'krita'
  fileType     = 'exe'
  silentArgs   = '/S'
  softwareName = 'Krita'

  checksumType = 'sha256'
  file64       = "$toolsDir\krita-x64-5.2.16-setup.exe"
}

Install-ChocolateyInstallPackage @packageArgs

Get-ChildItem $toolsDir\*.exe | ForEach-Object { Remove-Item $_ -ea 0; if (Test-Path $_) { Set-Content -Value '' -Path "$_.ignore" } }
