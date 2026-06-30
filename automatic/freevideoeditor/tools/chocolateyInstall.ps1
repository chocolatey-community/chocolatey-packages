$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://downloads.videosoftdev.com/video_tools/video_editor_x32.exe'
  file64         = "$toolsPath\video_editor_x64.exe"
  softwareName   = 'VSDC Free Video Editor*'
  silentArgs     = "/VERYSILENT /NORESTART /SUPPRESSMSGBOXES /SP- /LOG=`"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).InnoInstall.log`""
  validExitCodes = @(0)
  checksum       = '5E1A98424A5FF5F3D4D5350D40BADCA366E48C784D6B23F91314477BDB3936C0'
  checksumType   = 'sha256'
}

if ((Get-OSArchitectureWidth -compare 32) -or ($env:ChocolateyForceX86 -eq $true)) {
  Install-ChocolateyPackage @packageArgs
} else {
  Install-ChocolateyInstallPackage @packageArgs
}

Get-ChildItem $toolsPath\*.exe | ForEach-Object { Remove-Item $_ -ea 0; if (Test-Path $_) { Set-Content "$_.ignore" '' } }
