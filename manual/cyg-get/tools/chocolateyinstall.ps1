$path = Join-Path $(Split-Path -parent $MyInvocation.MyCommand.Definition) 'cyg-get.ps1'

Install-ChocolateyPowershellCommand 'cyg-get' $path