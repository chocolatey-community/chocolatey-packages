$toolsDir = Split-Path $MyInvocation.MyCommand.Definition
$is64     = (Get-OSArchitectureWidth 64) -and $env:chocolateyForceX86 -ne 'true'

$packageArgs = @{
    packageName   = 'krita'
    fileType      = 'exe'
    silentArgs    = "/S"    
    softwareName  = 'Krita'

    url           = 'https://download.kde.org/stable/krita/4.2.8/krita-x86-4.2.8-setup.exe'
    checksum      = '94FBDEE4A923682FD64C0010B17EBD002E52DE8F2AE239E611F3BDA60D8ABDEE'
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
