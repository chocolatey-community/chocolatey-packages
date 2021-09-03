$ErrorActionPreference = 'Stop'
$toolsDir = Split-Path $MyInvocation.MyCommand.Definition

#Remove old versions
$filter = [system.text.regularexpressions.regex]::escape((Join-Path $toolsDir "vlc"))
Remove-Process -PathFilter $filter | Out-Null
Get-ChildItem -Path $toolsDir | Where-Object { $_.PSIsContainer } | Remove-Item -EA 0 | Out-Null

$packageArgs = @{
  packageName    = 'vlc.portable'
  FileFullPath   = Get-Item "$toolsDir\*_x32.7z"
  Destination    = $toolsDir
  fileType       = ".7z"
}
Get-ChocolateyUnzip @packageArgs
Remove-Item ($toolsDir + '\*.' + $packageArgs.fileType)

$pp = Get-PackageParameters
if ($pp.Language) {
    Write-Host 'Setting langauge to' $pp.Language
    mkdir -force HKCU:\Software\VideoLAN\VLC
    Set-ItemProperty HKCU:\Software\VideoLAN\VLC Lang $pp.Language
}
