$ErrorActionPreference  = 'Stop'

$programFiles       = Join-Path ${env:ProgramFiles(x86)} 'DisplayFusion'
$localeTwoLetter    = (Get-Culture).TwoLetterISOLanguageName
$arguments          = @{
    packageName     = $env:ChocolateyPackageName
    softwareName    = 'DisplayFusion'
    url             = 'https://binaryfortressdownloads.com/Download/BFSFiles/101/DisplayFusionSetup-9.0.exe'
    checksum        = 'ceed1cd09a08c8f164917b8cc91b4d1f34d04726cddbd19d4bf6585a8ce2ad99'
    fileType        = 'exe'
    checksumType    = 'sha256'
    silentArgs      = "/VERYSILENT /LANG=$localeTwoLetter /DIR=`"$$programFiles`" /STARTUPALL=1 /CONTEXTMENU=0 /LAUNCHAFTER=0"
    validExitCodes  = @(0, 1641, 3010)
}

Install-ChocolateyPackage @arguments
