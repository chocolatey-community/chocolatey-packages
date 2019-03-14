$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName = $env:ChocolateyPackageName
  file        = "$toolsDir\BraveBrowserStandaloneSilentSetup32.exe"
  file64      = "$toolsDir\BraveBrowserStandaloneSilentSetup.exe"
}

Install-ChocolateyInstallPackage @packageArgs

Remove-Item $toolsDir\*.exe -ea 0
