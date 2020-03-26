$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName  = $env:ChocolateyPackageName
  softwareName = "simplewall*"
  file         = "$toolsDir\simplewall-3.1.2-setup.exe"
  fileType     = "exe"
  silentArgs   = "/S"
}

Install-ChocolateyInstallPackage @packageArgs

Get-ChildItem -Path $toolsDir\*.exe | ForEach-Object { Remove-Item $_ -ea 0; if (Test-Path $_) { Set-Content "$_.ignore" } }
