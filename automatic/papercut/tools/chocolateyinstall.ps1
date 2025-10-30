$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$pp = Get-PackageParameters

$directory = if ($pp.InstallDir) {
  $pp.InstallDir
} else {
  $toolsLocation = Get-ToolsLocation
  "$toolsLocation\$env:ChocolateyPackageName"
}

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'exe' #only one of these: exe, msi, msu
  file          = "$toolsDir\PapercutSMTP-win-x86-stable-Setup.exe"
  file64        = "$toolsDir\PapercutSMTP-win-x64-stable-Setup.exe"

  softwareName  = 'Papercut SMTP*' #part or all of the Display Name as you see it in Programs and Features. It should be enough to be unique
  # MSI
  silentArgs    = "--silent --installto `"$directory`""
  validExitCodes= @(0)
}

Install-ChocolateyInstallPackage @packageArgs
