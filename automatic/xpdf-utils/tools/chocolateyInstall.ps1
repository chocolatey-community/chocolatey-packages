$ErrorActionPreference = 'Stop';

$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Get-ChildItem "$toolsPath" -Filter "xpdfbin-win*" | `
  Where-Object { Test-Path $_.FullName -PathType Container } | `
  ForEach-Object { Remove-Item $_.FullName -Recurse }

$packageArgs = @{
  packageName = 'xpdf-utils'
  fileType    = 'zip'
  file        = "$toolsPath\xpdfbin-win-3.04.zip"
  destination = $toolsPath
}

Get-ChocolateyUnzip @packageArgs

if ((Get-ProcessorBits 32) -or ($env:ChocolateyForceX86 -eq $true)) {
  $dir = Get-Item "$toolsPath\*\bin64"
  Remove-Item -Force -Recurse -ea 0 $dir
} else {
  $dir = Get-Item "$toolsPath\*\bin32"
  Remove-Item -Force -Recurse -ea 0 $dir
}

Remove-Item "$toolsPath\*.zip" -Force -ea 0
