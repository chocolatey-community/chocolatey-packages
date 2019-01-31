$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName = $env:ChocolateyPackageName
  file        = "$toolsDir\brave32.exe"
  file64      = "$toolsDir\brave64.exe"
}

Start-Process 'AutoHotkey' "$toolsDir\install.ahk"

Install-ChocolateyInstallPackage @packageArgs

Remove-Item $toolsDir\*.exe -ea 0
