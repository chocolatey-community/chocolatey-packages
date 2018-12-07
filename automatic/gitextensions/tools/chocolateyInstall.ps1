$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
    packageName    = $env:ChocolateyPackageName
    softwareName   = 'Git Extensions*'
    fileType       = 'msi'
    file           = "$toolsDir\GitExtensions-3.00.00.03-RC2.msi"
    silentArgs     = '/quiet /norestart ADDDEFAULT=ALL REMOVE=AddToPath'
    validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyInstallPackage @packageArgs

ls $toolsPath\*.exe | % { rm $_ -ea 0; if (Test-Path $_) { sc "$_.ignore" '' } }

Install-BinFile gitex "$(Get-AppInstallLocation GitExtensions)\gitex.cmd"
