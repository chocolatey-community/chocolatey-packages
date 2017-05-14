. "$env:ChocolateyInstall\helpers\functions\Install-ChocolateyInstallPackage.ps1"
$installPackageFunc = Get-Item Function:\Install-ChocolateyInstallPackage | ? { $_.Parameters.ContainsKey('file64') }
if ($installPackageFunc) {
  return
}

Write-Debug "Loading Install-ChocolateyInstallPackage override"
Rename-Item Function:Install-ChocolateyInstallPackage Install-ChocolateyInstallPackageOriginal

<#
.SYNOPSIS
**NOTE:** Administrative Access Required.
Installs software into "Programs and Features". Use
Install-ChocolateyPackage when software must be downloaded first.
.DESCRIPTION
This will run an installer (local file) on your machine.
.NOTES
This command will assert UAC/Admin privileges on the machine.
If you are embedding files into a package, ensure that you have the
rights to redistribute those files if you are sharing this package
publicly (like on the community feed). Otherwise, please use
Install-ChocolateyPackage to download those resources from their
official distribution points.
This is a native installer wrapper function. A "true" package will
contain all the run time files and not an installer. That could come
pre-zipped and require unzipping in a PowerShell script. Chocolatey
works best when the packages contain the software it is managing. Most
software in the Windows world comes as installers and Chocolatey
understands how to work with that, hence this wrapper function.
.INPUTS
None
.OUTPUTS
None
.PARAMETER PackageName
The name of the package - while this is an arbitrary value, it's
recommended that it matches the package id.
.PARAMETER FileType
This is the extension of the file. This can be 'exe', 'msi', or 'msu'.
Licensed editions of Chocolatey use this to automatically determine
silent arguments. If this is not provided, Chocolatey will
automatically determine this using the downloaded file's extension.
.PARAMETER SilentArgs
OPTIONAL - These are the parameters to pass to the native installer,
including any arguments to make the installer silent/unattended.
Pro/Business Editions of Chocolatey will automatically determine the
installer type and merge the arguments with what is provided here.
Try any of the to get the silent installer -
`/s /S /q /Q /quiet /silent /SILENT /VERYSILENT`. With msi it is always
`/quiet`. Please pass it in still but it will be overridden by
Chocolatey to `/quiet`. If you don't pass anything it could invoke the
installer with out any arguments. That means a nonsilent installer.
Please include the `notSilent` tag in your Chocolatey package if you
are not setting up a silent/unattended package. Please note that if you
are submitting to the community repository, it is nearly a requirement
for the package to be completely unattended.
.PARAMETER File
Full file path to native installer to run. If embedding in the package,
you can get it to the path with
`"$(Split-Path -parent $MyInvocation.MyCommand.Definition)\\INSTALLER_FILE"`
In 0.10.1+, `FileFullPath` is an alias for File.
This can be a 32-bit or 64-bit file. This is mandatory in earlier versions
of Chocolatey, but optional if File64 has been provided.
.PARAMETER File64
Full file path to a 64-bit native installer to run. Available in 0.10.4+.
If embedding in the package, you can get it to the path with
`"$(Split-Path -parent $MyInvocation.MyCommand.Definition)\\INSTALLER_FILE"`
Provide this when you want to provide both 32-bit and 64-bit
installers or explicitly only a 64-bit installer (which will cause a package
install failure on 32-bit systems).
.PARAMETER ValidExitCodes
Array of exit codes indicating success. Defaults to `@(0)`.
.PARAMETER UseOnlyPackageSilentArguments
Do not allow choco to provide/merge additional silent arguments and
only use the ones available with the package. Available in 0.9.10+.
.PARAMETER IgnoredArguments
Allows splatting with arguments that do not apply. Do not use directly.
.EXAMPLE
>
$packageName= 'bob'
$toolsDir   = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"
$fileLocation = Join-Path $toolsDir 'INSTALLER_EMBEDDED_IN_PACKAGE'
$packageArgs = @{
  packageName   = $packageName
  fileType      = 'msi'
  file          = $fileLocation
  silentArgs    = "/qn /norestart"
  validExitCodes= @(0, 3010, 1641)
  softwareName  = 'Bob*'
}
Install-ChocolateyInstallPackage @packageArgs
.EXAMPLE
$packageName= 'bob'
$toolsDir   = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"
$fileLocation = Join-Path $toolsDir '32BIT_INSTALLER_EMBEDDED_IN_PACKAGE'
$fileLocation64 = Join-Path $toolsDir '64BIT_INSTALLER_EMBEDDED_IN_PACKAGE'

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'msi'
  file          = $fileLocation
  file64        = $fileLocation64
  silentArgs    = "/qn /norestart"
  validExitCodes= @(0, 3010, 1641)
  softwareName  =
}

Install-ChocolateyInstallPackageEx @packageArgs
.EXAMPLE
>
$packageArgs = @{
  packageName   = 'bob'
  fileType      = 'exe'
  file          = '\\SHARE_LOCATION\to\INSTALLER_FILE'
  silentArgs    = "/S"
  validExitCodes= @(0)
  softwareName  = 'Bob*'
}
Install-ChocolateyInstallPackage @packageArgs
.EXAMPLE
Install-ChocolateyInstallPackage 'bob' 'exe' '/S' "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)\bob.exe"
.EXAMPLE
>
Install-ChocolateyInstallPackage -PackageName 'bob' -FileType 'exe' `
  -SilentArgs '/S' `
  -File "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)\bob.exe" `
  -ValidExitCodes = @(0)
.LINK
Install-ChocolateyPackage
.LINK
Uninstall-ChocolateyPackage
.LINK
Get-UninstallRegistryKey
.LINK
Start-ChocolateyProcessAsAdmin
#>
function Install-ChocolateyInstallPackage {
  param(
    [parameter(Mandatory=$true, Position=0)][string] $packageName,
    [parameter(Mandatory=$false, Position=1)]
    [alias("installerType","installType")][string] $fileType = 'exe',
    [parameter(Mandatory=$false, Position=2)][string[]] $silentArgs = '',
    [alias("fileFullPath")][parameter(Mandatory=$false, Position=3)][string] $file,
    [alias("fileFullPath64")][Parameter(Mandatory=$false)][string] $file64,
    [parameter(Mandatory=$false)] $validExitCodes = @(0),
    [parameter(Mandatory=$false)]
    [alias("useOnlyPackageSilentArgs")][switch] $useOnlyPackageSilentArguments = $false,
    [parameter(ValueFromRemainingArguments = $true)][Object[]] $ignoredArguments
  )
  $bitnessMessage = ''
  $fileFullPath = $file
  if ((Get-ProcessorBits 32) -or $env:ChocolateyForceX86 -eq 'true') {
    if (!$file) { throw "32-bit installation is not supported for $packageName" }
    if ($file64) { $bitnessMessage = '32-bit ' }
  } elseif( $file64) {
    $fileFullPath = $file64
    $bitnessMessage = '64-bit '
  }

  if ($fileFullPath -eq '' -or $fileFullPath -eq $null) {
    throw "Package parameters incorrect, either File or File64 must be specified."
  }

  Write-Host "Installing $bitnessMessage$packageName..."

  $packageArgs = @{
    packageName    = $packageName
    fileType       = $fileType
    silentArgs     = $silentArgs
    file           = $fileFullPath
    validExitCodes = $validExitCodes
    useOnlyPackageSilentArgs = $useOnlyPackageSilentArguments
    ignoredArguments = $ignoredArguments
  }

  Install-ChocolateyInstallPackageOriginal @packageArgs
}

# We need to force the export of Install-ChocolateyInstall function
Export-ModuleMember -Function Install-ChocolateyInstallPackage
