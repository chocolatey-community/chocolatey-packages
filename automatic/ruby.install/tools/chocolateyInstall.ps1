$ErrorActionPreference = 'Stop'

$toolsPath = "$(Split-Path -Path ${MyInvocation}.MyCommand.Definition -Parent)"
$verDigits = (${Env:ChocolateyPackageVersion} -replace '\D').Substring(0,2)
if (${verDigits}.Length -ne 2) {
  throw "Invalid Chocolatey package version: '${Env:ChocolateyPackageVersion}'"
}
$rubyDir = 'ruby' + ${verDigits}

$pp = Get-PackageParameters
$installDir = if (-not [string]::IsNullOrWhiteSpace($pp['InstallDir'])) {
  $pp['InstallDir']
} else {
  Join-Path -Path (Get-ToolsLocation) -ChildPath ${rubyDir}
}

$tasks = @('noridkinstall')
if (-not $pp['DefaultUTF8']) {
  $tasks += 'nodefaultutf8'
} else {
  $tasks += 'defaultutf8'
}
if (-not $pp['NoFileAssoc']) {
  $tasks += 'assocfiles'
} else {
  $tasks += 'noassocfiles'
}
if (-not $pp['NoPath']) {
  $tasks += 'modpath'
} else {
  $tasks += 'nomodpath'
}

Write-Information "Ruby target installation directory: '${installDir}'."

$exeName = 'rubyinstaller-4.0.2-1-x64.exe'
$exePath = Join-Path -Path ${toolsPath} -ChildPath ${exeName}

$packageArgs = @{
  packageName    = ${Env:ChocolateyPackageName}
  fileType       = 'exe'
  file64         = ${exePath}
  silentArgs     = '/VERYSILENT /NORESTART /SP- /ALLUSERS /DIR="{0}" /TASKS="{1}"' -f ${installDir}, (${tasks} -join ',')
  validExitCodes = @(0)
  softwareName   = 'ruby *'
}

Install-ChocolateyInstallPackage @packageArgs

Get-ChildItem -Path ${toolsPath} -File -Filter '*.exe' | ForEach-Object {
  Remove-Item -LiteralPath $_.FullName -Force -ErrorAction SilentlyContinue
  if (-not (Test-Path -LiteralPath $_.FullName)) {
    Set-Content -LiteralPath ($_.FullName + '.ignore') -Value '' -ErrorAction SilentlyContinue
  }
}
