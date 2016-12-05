Function Install-ChocolateyFosshub() {
<#
.SYNOPSIS
**NOTE:** Administrative Access Required.

Downloads from fosshub and install software into "Programs and Features"

.DESCRIPTION
This will download a native installer from the fosshub url and install it on your
machine.

.NOTES
See Install-ChocolateyPackage for additional notes.
#>
  param(
    [parameter(Mandatory=$true, Position=0)][string] $packageName,
    [parameter(Mandatory=$false, Position=1)]
    [alias("installerType","installType")][string] $fileType = 'exe',
    [parameter(Mandatory=$false, Position=2)][string[]] $silentArgs = '',
    [parameter(Mandatory=$false, Position=3)][string] $url = '',
    [parameter(Mandatory=$false, Position=4)]
    [alias("url64")][string] $url64bit = '',
    [parameter(Mandatory=$false)] $validExitCodes = @(0),
    [parameter(Mandatory=$false)][string] $checksum = '',
    [parameter(Mandatory=$false)][string] $checksumType = '',
    [parameter(Mandatory=$false)][string] $checksum64 = '',
    [parameter(Mandatory=$false)][string] $checksumType64 = '',
    [parameter(Mandatory=$false)][hashtable] $options = @{Headers=@{}},
    [parameter(Mandatory=$false)][switch] $forceDownload,
    [alias("useOnlyPackageSilentArgs")][switch] $useOnlyPackageSilentArguments = $false,
    [parameter(ValueFromRemainingArguments = $true)][Object[]] $ignoredArguments
  )

  $filePath = Get-FosshubWebFile -PackageName $packageName `
                                 -Url $url `
                                 -Url64bit $url64bit `
                                 -Checksum $checksum `
                                 -ChecksumType $checksumType `
                                 -Checksum64 $checksum64 `
                                 -ChecksumType64 $checksumType64 `
                                 -Options $options

  Install-ChocolateyInstallPackage -PackageName $packageName `
                                   -FileType $fileType `
                                   -SilentArgs $silentArgs `
                                   -File $filePath `
                                   -ValidExitCodes $validExitCodes `
                                   -UseOnlyPackageSilentArguments $useOnlyPackageSilentArguments
}
