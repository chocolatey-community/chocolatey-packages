$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# Place shortcuts in appropriate location
$ProgsFolder = [environment]::getfolderpath('Programs')
If ( Test-ProcessAdminRights ) {
  $ProgsFolder = Join-Path ([environment]::getfolderpath('CommonApplicationData')) "Microsoft\Windows\Start Menu\Programs"
}

# Unique names for each bitness
$binName = "Veedub64.exe"
If ((Get-OSArchitectureWidth -compare '32') -or $env:ChocolateyForceX86 -eq $true) { $binName = "VirtualDub.exe" }

$packageArgs = @{
  packageName      = 'virtualdub'
  file             = "$toolsDir\VirtualDub-1.10.4.zip"
  file64           = "$toolsDir\VirtualDub-1.10.4-AMD64.zip"
  destination      = "$toolsDir"
  shortcutFilePath = "$ProgsFolder\VirtualDub.lnk"
  targetPath       = "$toolsDir\$binName"
}

Get-ChocolateyUnzip @packageArgs
Install-ChocolateyShortcut @packageArgs
Install-BinFile -Path "$toolsDir\$binName" -Name $packageArgs.packageName -UseStart

Remove-Item -Force -ea 0 "$toolsDir\*.zip"

Get-ChildItem $toolsDir -Recurse -Filter "*.exe" | % { Set-Content -Path  "$($_.FullName).ignore" -Value '' }
