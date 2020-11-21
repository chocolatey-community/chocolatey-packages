$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
$file = ''
$file64 = ''

$packageArgs = @{
  packageName    = ''
  fileType       = ''
  file           = "$toolsPath\$file"
  file64         = "$toolsPath\$file64"
  silentArgs     = '/S'
  validExitCodes = @(0)
  softwareName   = ''
}

Install-ChocolateyPackage @packageArgs
Remove-Item $toolsPath\*.exe -ea 0

$packageName = $packageArgs.packageName
$installLocation = Get-AppInstallLocation $packageArgs.softwareName
if (!$installLocation)  { Write-Warning "Can't find $packageName install location"; return }
Write-Host "$packageName installed to '$installLocation'"

@('dot') |ForEach-Object {Install-BinFile $_ "$installLocation\bin\$_.exe"}
