$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
    packageName    = 'sublimetext3dev'
    softwareName   = 'Sublime Text 3 Dev Build'

    fileType       = 'exe'
    file           = "$toolsPath\"
    file64         = "$toolsPath\"

    silentArgs     = '/VERYSILENT /NORESTART /TASKS="contextentry"'
    validExitCodes = @(0)
}

Install-ChocolateyInstallPackage @packageArgs

# clean up
Get-ChildItem $toolsPath\*.exe | ForEach-Object { Remove-Item $_ -ea 0 }
