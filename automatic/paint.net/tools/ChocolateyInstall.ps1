$ErrorActionPreference  = 'Stop'
$arguments              = @{
    packageName         =  $env:ChocolateyPackageName
    softwareName        = 'Paint.NET*'
    url                 = 'https://www.dotpdn.com/files/paint.net.4.0.16.install.zip'
    checksum            = 'f79b615a6d9ec93f0a00547814c96ad7e74397214a94e0eb53be021144dccd90'
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
