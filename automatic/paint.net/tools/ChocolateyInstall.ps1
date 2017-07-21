$ErrorActionPreference  = 'Stop'
$arguments              = @{
    packageName         =  $env:ChocolateyPackageName
    softwareName        = 'Paint.NET*'
    url                 = 'https://www.dotpdn.com/files/paint.net.4.0.17.install.zip'
    checksum            = '4c6f4a582bcdc8e46898d13e6eafc6358c21d8db203dce4ef26ab149f820752f'
    fileType            = 'zip'
    destination         = Join-Path $env:Temp 'Paint.NET'
    checksumType        = 'sha256'
    silentArgs          = '/auto'
    validExitCodes      = @(0, 1641, 3010)
}

Install-ChocolateyZipPackage @arguments

$arguments.file = Get-ChildItem $arguments.destination -Recurse -Include *.exe | Select-Object -First 1
$arguments.fileType ='exe'

Install-ChocolateyInstallPackage @arguments

Remove-Item $arguments.destination -Recurse -Force
