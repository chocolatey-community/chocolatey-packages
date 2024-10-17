$toolsDir = Split-Path -parent $MyInvocation.MyCommand.Definition
. "$toolsDir\helpers.ps1"

$pp = Get-PackageParameters

$arguments = @{
    packageName      = $env:chocolateyPackageName
    file             = "$toolsDir\httpd-2.4.59-240404-win32-vs17.zip"
    file64           = "$toolsDir\httpd-2.4.59-240404-win64-VS17.zip"
    destination      = if ($pp.installLocation) { $pp.installLocation } else { $env:APPDATA }
    port             = if ($pp.Port) { $pp.Port } else { 8080 }
    serviceName      = if ($pp.NoService) { $null } elseif ($pp.serviceName) { $pp.serviceName } else { 'Apache2.4' }
    startService     = if ($pp.NoStartService) { $false } else { $true }
    setConfiguration = if ($pp.SkipConfiguration) { $false } else { $true }
}

if ($arguements.setConfiguration -and -not (Assert-TcpPortIsOpen $arguments.port)) {
    throw 'Please specify a different port number...'
}

Install-Apache $arguments
