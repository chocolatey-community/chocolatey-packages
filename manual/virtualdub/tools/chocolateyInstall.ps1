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

# Unique names for each bitness
$binName = "Veedub64.exe"
If ( Get-OSArchitectureWidth -compare '32' ) { $binName = "VirtualDub.exe" }

# Place shortcuts in appropriate location
$ProgsFolder = [environment]::getfolderpath('Programs')
If ( Test-ProcessAdminRights ) { $ProgsFolder = [environment]::getfolderpath('CommonPrograms') }
Install-ChocolateyShortcut -shortcutFilePath "$ProgsFolder\VirtualDub.lnk" -targetPath "$toolsDir\$binName"
