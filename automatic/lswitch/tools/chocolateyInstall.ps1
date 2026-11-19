$ErrorActionPreference = 'Stop'

$toolsDir = $(Split-Path -parent $MyInvocation.MyCommand.Definition)

$packageArgs = @{
    packageName   = 'lswitch'
    url           = 'https://haali.net/winutils/lswitch.exe'
    checksum      = '30B02967F7A284AC065DD89F885335FE869B0D1D720FED0EA4C5948AA4F83B28'
    checksumType  = 'sha256'
    fileFullPath  = Join-Path $toolsDir 'lswitch.exe'
}

Get-ChocolateyWebFile @packageArgs