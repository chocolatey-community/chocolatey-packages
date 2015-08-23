# Note: fosshub uses special links that expire. The Get-FosshubLinks function
# takes care of generating these links.

$PSScriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Definition
Import-Module (Join-Path $PSScriptRoot 'get-fosshublinks.ps1')

$packageName = '{{PackageName}}'
$fileType = 'exe'
$fileArgs = '/VERYSILENT'
$version = '{{PackageVersion}}'

$url = Get-FosshubLinks "http://www.fosshub.com/genLink/Audacity/audacity-win-${version}.exe"

Install-ChocolateyPackage $packageName $fileType $fileArgs $url
