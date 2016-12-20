$PSScriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Definition
Import-Module (Join-Path $PSScriptRoot 'functions.ps1')

$fileFullPath = Join-Path $PSScriptRoot 'keepass_1.x_langfiles.zip'
$keepassInstallPath = (Get-InstallProperties).InstallLocation

$extractPath = Join-Path $PSScriptRoot 'keepass-classic-langfiles'
if (-not (Test-Path $extractPath)) {
  mkdir $extractPath
}

Get-ChocolateyUnzip $fileFullPath $extractPath
Start-ChocolateyProcessAsAdmin "Copy-Item -Force '$extractPath\*.lng' '$keepassInstallPath'"
