$packageName = 'gitextensions'
$softwareName = 'Git Extensions*'
$installerType = 'msi'
$installArgs = '/quiet /norestart'
$url = 'https://github.com/gitextensions/gitextensions/releases/download/v2.50.01/GitExtensions-2.50.01-Setup.msi'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'MSI'
  url           = $url
  silentArgs    = "/quiet /norestart"
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs

#------- ADDITIONAL SETUP -------#

$osBitness = Get-ProcessorBits
$is64bit = $osBitness -eq 64

$progFiles = [System.Environment]::GetFolderPath('ProgramFiles')
if ($is64bit -and $progFiles -notmatch 'x86') {$progFiles = "$progFiles (x86)"}

$gitexPath = Join-Path $progFiles 'GitExtensions'
Write-Host "Adding `'$gitexPath`' to the PATH so you can call gitex from the command line."
Install-ChocolateyPath $gitexPath
$env:Path = "$($env:Path);$gitexPath"
