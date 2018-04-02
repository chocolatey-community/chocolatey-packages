$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
file          = "$toolsDir\krita-x86-4.0.0-setup.exe"
file64        = "$toolsDir\krita-x64-4.0.0-setup.exe"
fileType      = 'exe'
packageName   = 'krita'
softwareName  = 'Krita'
silentArgs    = "/S"
}

Install-ChocolateyInstallPackage @packageArgs
Get-ChildItem $toolsDir\*.exe | ForEach-Object { Remove-Item $_ -ea 0; if (Test-Path $_) { Set-Content -Value "" -Path "$_.ignore" }}
