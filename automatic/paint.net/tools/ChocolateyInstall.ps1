$ErrorActionPreference  = 'Stop'
$arguments              = @{
    packageName         =  $env:ChocolateyPackageName
    softwareName        = 'Paint.NET*'
    url                 = 'https://www.dotpdn.com/files/paint.net.4.0.18.install.zip'
    checksum            = 'f254361cab183d637d4915b6fa321254132158d02491ad5243357868c0b07785'
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
