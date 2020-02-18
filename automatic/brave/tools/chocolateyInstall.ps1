$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName = $env:ChocolateyPackageName
  file        = "$toolsDir\BraveBrowserStandaloneSilentBetaSetup32.exe"
  file64      = "$toolsDir\BraveBrowserSilentBetaSetup.exe"
}

Install-ChocolateyInstallPackage @packageArgs

Remove-Item $toolsDir\*.exe -ea 0
