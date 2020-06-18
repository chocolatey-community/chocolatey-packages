$toolsDir = Split-Path $MyInvocation.MyCommand.Definition
$is64     = (Get-OSArchitectureWidth 64) -and $env:chocolateyForceX86 -ne 'true'

$packageArgs = @{
    packageName   = 'krita'
    fileType      = 'exe'
    silentArgs    = "/S"    
    softwareName  = 'Krita'

    url           = 'https://download.kde.org/stable/krita/4.3.0/krita-x86-4.3.0-setup.exe'
    checksum      = '15018230D2FD5CAA8A3778B1FF88B0582D93255108E1E5F781880D1D5401E9E3'
    checksumType  = 'sha256'
    file64        = Get-Item $toolsDir\*.exe
}

# https://github.com/chocolatey-community/chocolatey-coreteampackages/issues/1289#issuecomment-498815481
if ($is64) { 
    $packageArgs.Remove('url');
    $packageArgs.Remove('checksum')
    $packageArgs.Remove('checksumType')
    Install-ChocolateyInstallPackage @packageArgs    
} else { 
    $packageArgs.Remove('file64')
    Install-ChocolateyPackage @packageArgs
}

Get-ChildItem $toolsDir\*.exe | ForEach-Object { Remove-Item $_ -ea 0; if (Test-Path $_) { Set-Content -Value "" -Path "$_.ignore" }}
