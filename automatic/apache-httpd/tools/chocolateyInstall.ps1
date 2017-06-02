$PSScriptRoot = Split-Path $MyInvocation.MyCommand.Path -Parent
$toolsDir = Split-Path -parent $MyInvocation.MyCommand.Definition

. (Join-Path $PSScriptRoot 'Helpers.ps1')

$pp = Get-PackageParameters

$fileName32 = 'httpd-2.4.25-x86-vc14-r1.zip'
$fileName64 = 'httpd-2.4.25-x64-vc14-r1.zip'
$packageArgs = @{
    packageName = $env:chocolateyPackageName
    file        = Join-Path $toolsDir $fileName32
    file64      = Join-Path $toolsDir $fileName64
    destination = if ($pp.installLocation) { $pp.installLocation } else { $env:APPDATA }
    port        = if ($pp.Port) { $pp.Port } else { 80 }
    serviceName = if ($pp.serviceName) { $pp.serviceName } else { 'Apache' }
}

if (-not (Assert-TcpPortIsOpen $packageArgs.port)) {
    throw 'Please specify a different port number...'
}

Get-ChocolateyUnzip `
    -file $packageArgs.file `
    -file64 $packageArgs.file64 `
    -destination $packageArgs.destination

$apacheDir = Get-ChildItem $packageArgs.destination -Directory -Filter 'Apache*' | Select-Object -First 1 -ExpandProperty FullName
$httpdConfPath = Join-Path $apacheDir 'conf\httpd.conf'
$httpdPath = Join-Path $apacheDir 'bin\httpd.exe'

# Set the server root and port number
$httpConf = Get-Content $httpdConfPath
$httpConf = $httpConf -replace 'Define SRVROOT.*', "Define SRVROOT ""$($apacheDir -replace '\\', '/')"""
$httpConf = $httpConf -replace 'Listen 80', "Listen $($packageArgs.port)"
Set-Content -Path $httpdConfPath -Value $httpConf -Encoding Ascii

& $httpdPath -k install -n "$($packageArgs.serviceName)"

$config = @{
    destination = $apacheDir
    httpdPath   = $httpdPath
    serviceName = $packageArgs.serviceName
}
$configFile = Join-Path $toolsDir 'config.json'
Set-Content $configFile -Value ($config | ConvertTo-Json)
