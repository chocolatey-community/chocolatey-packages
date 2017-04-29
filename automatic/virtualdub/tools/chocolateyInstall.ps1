$packageName = 'virtualdub'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$version = '{{PackageVersion}}'
$build = '{{Build}}'
$url = "https://sourceforge.net/projects/virtualdub/files/virtualdub-win/${version}.${build}/VirtualDub-${version}.zip/download"
$url64 = "https://sourceforge.net/projects/virtualdub/files/virtualdub-win/${version}.${build}/VirtualDub-${version}-AMD64.zip/download"
$checksum = '{{Checksum}}'
$checksum64 = '{{Checksumx64}}'
$checksumType = 'SHA512'

Install-ChocolateyZipPackage $packageName $url $toolsdir $url64 `
-Checksum $checksum -ChecksumType $checksumType -Checksum64 $checksum64

$admin = Test-ProcessAdminRights
$bitness = Get-OSArchitectureWidth

# Unique names for each bitness
if ( $bitness -eq '64' ) {
	$binName = "Veedub64.exe"
} else {
	$binName = "VirtualDub.exe"
}

# Place shortcuts in appropriate location
if ( $admin -eq $true ) {
	$commProgs = [environment]::getfolderpath('CommonPrograms')
	Install-ChocolateyShortcut -shortcutFilePath "$commProgs\VirtualDub.lnk" -targetPath "$toolsDir\$binName"
} Else { 
	$userProgs = [environment]::getfolderpath('Programs')
	Install-ChocolateyShortcut -shortcutFilePath "$userProgs\VirtualDub.lnk" -targetPath "$toolsDir\$binName"
}
