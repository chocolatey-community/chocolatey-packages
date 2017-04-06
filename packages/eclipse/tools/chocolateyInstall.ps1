$packageName = '{{PackageName}}'
$packageVersion = '{{PackageVersion}}'
$32BitUrl = '{{DownloadUrl}}'
$64BitUrl = '{{DownloadUrlx64}}'
$global:installLocation = "C:\Program Files\Eclipse Foundation\$packageVersion"
$checksum = '{{Checksum}}'
$checksumType = 'md5'
$checksum64 = '{{Checksumx64}}'
$checksumType64 = 'md5'

if(!$PSScriptRoot){ $PSScriptRoot = Split-Path $MyInvocation.MyCommand.Path -Parent }
. "$PSScriptRoot\OverwriteParameters.ps1"

OverwriteParameters

Install-ChocolateyZipPackage "$packageName" "$32BitUrl" "$global:installLocation" "$64BitUrl" -checksum "$checksum" -checksumType "$checksumType" -checksum64 "$checksum64" -checksumType64 "$checksumType64"

$eclipseExecutable = "$global:installLocation\eclipse\eclipse.exe"

Install-ChocolateyDesktopLink "$eclipseExecutable"
Install-ChocolateyPinnedTaskBarItem "$eclipseExecutable"