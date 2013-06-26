
$path = Join-Path $(Split-Path -parent $(Split-Path -parent $MyInvocation.MyCommand.Definition)) 'content\cyg-get.ps1'

Install-ChocolateyPowershellCommand 'cyg-get' $path
