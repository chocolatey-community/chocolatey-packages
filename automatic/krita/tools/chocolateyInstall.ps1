$toolsDir = Split-Path $MyInvocation.MyCommand.Definition
$is64     = (Get-OSArchitectureWidth 64) -and $env:chocolateyForceX86 -ne 'true'

$packageArgs = @{
    packageName   = 'krita'
    fileType      = 'exe'
    silentArgs    = "/S"    
    softwareName  = 'Krita'

    url           = 'https://download.kde.org/stable/krita/4.2.9/krita-x86-4.2.9-setup.exe'
    checksum      = 'C8EFE945804EC9F08F019853C60895E390EDFEB03BDE13874B4D05231C03261D'
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
