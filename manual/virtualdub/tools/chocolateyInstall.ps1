$packageName = 'virtualdub'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = "file://$toolsDir/VirtualDub-1.10.4.zip"
$url64 = "file://$toolsDir/VirtualDub-1.10.4-AMD64.zip"

Install-ChocolateyZipPackage $packageName $url $toolsdir $url64

# Unique names for each bitness
$binName = "Veedub64.exe"
If ( Get-OSArchitectureWidth -compare '32' ) { $binName = "VirtualDub.exe" }

# Place shortcuts in appropriate location
$ProgsFolder = [environment]::getfolderpath('Programs')
If ( Test-ProcessAdminRights ) {
  $ProgsFolder = Join-Path `
	([environment]::getfolderpath('CommonApplicationData')) `
	"Microsoft\Windows\Start Menu\Programs"
}
Install-ChocolateyShortcut -shortcutFilePath "$ProgsFolder\VirtualDub.lnk" -targetPath "$toolsDir\$binName"

Remove-Item -Force -ea 0 "$toolsDir\VirtualDub-1.10.4.zip"
Remove-Item -Force -ea 0 "$toolsDir\VirtualDub-1.10.4-AMD64.zip"
