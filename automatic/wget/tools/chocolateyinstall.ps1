$ErrorActionPreference = 'Stop';

$packageName= 'wget'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$zipFile = if ((Get-ProcessorBits 64) -and $env:chocolateyForceX86 -ne 'true') {
         Write-Host "Getting x64 bit zip"; Get-Item "$toolsDir\*_x64.zip"
} else { Write-Host "Getting x32 bit zip"; Get-Item "$toolsDir\*_x32.zip" }

Get-ChocolateyUnzip -FileFullPath $zipfile -Destination $toolsDir

# don't need zips anymore
Remove-Item ($toolsDir + '\*.' + 'zip')
