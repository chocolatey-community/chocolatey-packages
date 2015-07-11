$PSScriptRoot = Split-Path -parent $MyInvocation.MyCommand.Definition

Import-Module (Join-Path $PSScriptRoot 'Get-UrlFromFosshub.ps1')

$packageName = '{{PackageName}}'
$fileType = 'exe'
$silentArgs = '/S'

# {\{DownloadUrlx64}\} gets “misused” here as genLink
# part for FossHub (only visible in the template, not in
# the final file generated for the package.)
$genLinkUrl = '{{DownloadUrlx64}}32.exe'
$genLinkUrl64bit = '{{DownloadUrlx64}}64.exe'
$validExitCodes = @(0, 1223)

$url = Get-UrlFromFosshub $genLinkUrl
$url64bit = Get-UrlFromFosshub $genLinkUrl64bit

Install-ChocolateyPackage $packageName $fileType $silentArgs `
  $url $url64bit -validExitCodes $validExitCodes
