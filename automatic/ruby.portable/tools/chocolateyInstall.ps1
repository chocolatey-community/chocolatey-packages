$ErrorActionPreference = 'Stop'
$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  File        = "$toolsPath\rubyinstaller-3.4.6-1-x86.7z"
  File64      = "$toolsPath\rubyinstaller-3.4.6-1-x64.7z"
  Destination = "$toolsPath\ruby"
  PackageName = $env:ChocolateyPackageName
}

Get-ChocolateyUnzip @packageArgs

# Add shims for .bat and .cmd files, in the bin folder, that Chocolatey CLI will not shim
$rubyDir = Join-Path -Path $toolsPath -ChildPath 'ruby\ruby*\bin\'
'*.bat', '*.cmd' | ForEach-Object {
  Get-ChildItem -Path (Join-Path -Path $rubyDir -ChildPath $_) | ForEach-Object {
    Install-BinFile -Name $_.BaseName -Path $_.FullName
  }
}

Get-ChildItem $toolsPath\*.7z | ForEach-Object { Remove-Item $_ -ea 0 }
