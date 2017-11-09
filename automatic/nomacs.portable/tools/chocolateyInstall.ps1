$ErrorActionPreference = 'Stop'

if ((Get-ProcessorBits 32) -or ($env:chocolateyForceX86 -eq 'true')) {
   throw "This package doesn't support 32bit architecture"
}

$fileName  = 'nomacs-3.8.0.zip'
$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
$zip_path = "$toolsPath\$fileName"
ls $toolsPath\* | ? { $_.PSIsContainer } | rm -Force -Recurse

$packageArgs = @{
    PackageName  = 'nomacs.portable'
    FileFullPath = $zip_path
    Destination  = $toolsPath
}
Get-ChocolateyUnzip @packageArgs
rm $zip_path -ea 0
