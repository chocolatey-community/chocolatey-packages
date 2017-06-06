$PSScriptRoot = Split-Path $MyInvocation.MyCommand.Path -Parent

. (Join-Path $PSScriptRoot 'helpers.ps1')

$configFile = Join-Path $env:chocolateyPackageFolder 'config.json'

$packageArgs = @{
    packageName     = $env:chocolateyPackageName
    url             = 'https://www.apachehaus.com/downloads/httpd-2.4.25-x86-vc14-r1.zip'
    url64           = 'https://www.apachehaus.com/downloads/httpd-2.4.25-x64-vc14-r1.zip'
    checksum        = 'c3a64bfe00303c89412df0764b80be0540b03f2ccdb73cdfe5256e9eeb0744fd'
    checksum64      = '449355e68fac3d7da6bc703fd1c29be903dd990295b78f85ae67d5c628c09e61'
    checksumType    = 'sha256'
    checksumType64  = 'sha256'
    unzipLocation   = $env:chocolateyPackageFolder
    installLocation = $env:APPDATA
    port            = 80
    serviceName     = 'Apache'
}

$packageParameters = Get-PackageParameters
if ($packageParameters.installLocation) {
    $packageArgs.installLocation = $packageParameters.installLocation
}
if ($packageParameters.port) {
    $packageArgs.port = $packageParameters.port
}
if ($packageParameters.serviceName) {
    $packageArgs.serviceName = $packageParameters.serviceName
}

if (-not (Assert-TcpPortIsOpen $packageArgs.port)) {
    throw 'Please specify a different port number...'
}

Install-ChocolateyZipPackage @packageArgs

$apacheDir = Get-ChildItem $packageArgs.unzipLocation -Directory -Filter 'Apache*'

Move-Item $apacheDir.FullName $packageArgs.installLocation

$apacheDir = Join-Path $packageArgs.installLocation $apacheDir.BaseName
$httpdConfPath = Join-Path $apacheDir 'conf\httpd.conf'
$httpdPath = Join-Path $apacheDir 'bin\httpd.exe'

# Set the server root and port number
$httpConf = Get-Content $httpdConfPath
$httpConf = $httpConf -replace 'Define SRVROOT.*', "Define SRVROOT ""$($apacheDir -replace '\\', '/')"""
$httpConf = $httpConf -replace 'Listen 80', "Listen $($packageArgs.port)"
Set-Content -Path $httpdConfPath -Value $httpConf

& $httpdPath -k install -n "$($packageArgs.serviceName)"

$config = @{
    installLocation = $apacheDir
    httpdPath       = $httpdPath
    serviceName     = $packageArgs.serviceName
}

Set-Content $configFile -Value ($config | ConvertTo-Json)
