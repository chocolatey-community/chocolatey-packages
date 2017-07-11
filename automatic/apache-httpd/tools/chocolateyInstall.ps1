. (Join-Path (Split-Path -parent $MyInvocation.MyCommand.Definition) 'Helpers.ps1')

$toolsDir = Split-Path -parent $MyInvocation.MyCommand.Definition

$pp = Get-PackageParameters

$fileName32 = 'httpd-2.4.27-x86-vc14.zip'
$fileName64 = 'httpd-2.4.27-x64-vc14.zip'
$arguments = @{
    packageName = $env:chocolateyPackageName
    file        = Join-Path $toolsDir $fileName32
    file64      = Join-Path $toolsDir $fileName64
    destination = if ($pp.installLocation) { $pp.installLocation } else { $env:APPDATA }
    port        = if ($pp.Port) { $pp.Port } else { 8080 }
    serviceName = if ($pp.serviceName) { $pp.serviceName } else { 'Apache' }
}

if (-not (Assert-TcpPortIsOpen $arguments.port)) {
    throw 'Please specify a different port number...'
}

Install-Apache $arguments
