$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
$isExe = $Env:ChocolateyPackageName -eq 'vlc'
$filetype = 'zip'

$packageArgsExe = @{
  packageName    = 'vlc'
  fileType       = 'exe'
  file           = gi $toolsPath\*-win32.exe
  file64         = gi $toolsPath\*-win64.exe
  silentArgs     = '/S'
  validExitCodes = @(0, 1223)
}

$packageArgsZip = @{
  PackageName    = 'vlc.portable'
  FileFullPath   = gi $toolsPath\*-win32.zip
  FileFullPath64 = gi $toolsPath\*-win64.zip
  Destination    = $toolsPath
}

if ($isExe) {
  Install-ChocolateyInstallPackage @packageArgsExe }
else {
  ls $toolsPath\* | ? { $_.PSISContainer } | rm -Recurse -Force
  Get-ChocolateyUnzip @packageArgsZip
}
ls $toolsPath\*.$filetype | % { rm $_ -ea 0; if (Test-Path $_) { sc "$_.ignore" } }

$pp = Get-PackageParameters
if ($pp.Language) {
    Write-Host 'Setting langauge to' $pp.Language
    mkdir -force HKCU:\Software\VideoLAN\VLC
    sp HKCU:\Software\VideoLAN\VLC Lang $pp.Language
}

if (!$isExe) { return }

$packageName = $packageArgs.packageName
$installLocation = Get-AppInstallLocation $packageName
if ($installLocation)  {
    Write-Host "$packageName installed to '$installLocation'"
    Register-Application "$installLocation\$packageName.exe"
    Write-Host "$packageName registered as $packageName"
}
else { Write-Warning "Can't find $PackageName install location" }
