$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  softwareName  = "BleachBit"
  file          = "$toolsDir\BleachBit-1.17-setup.exe"
  fileType      = "exe"
  silentArgs    = "/S"
}

Install-ChocolateyInstallPackage @packageArgs

Get-ChildItem -Path $toolsDir\*.exe | % { Remove-Item $_ -ea 0; if (Test-Path $_) { Set-Content "$_.ignore" } }
