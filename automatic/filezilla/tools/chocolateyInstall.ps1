$packageName = '{{packageName}}'
$version = '{{PackageVersion}}'
$fileType = 'exe'
$silentArgs = '/S'
$url = "https://sourceforge.net/projects/filezilla/files/FileZilla_Client/${version}/FileZilla_${version}_win32-setup.exe/download"
$url64bit = "https://sourceforge.net/projects/filezilla/files/FileZilla_Client/${version}/FileZilla_${version}_win64-setup.exe/download"

# Even though the installer exits with error code 1223, FileZilla gets installed properly
$validExitCodes = @(0, 1223)

$is64bit = Get-ProcessorBits 64

$regPath = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\FileZilla Client'
$regPathWow6432 = 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\FileZilla Client'

# If the 32-bit version was installed on a 64-bit system, uninstall it first
if ((Test-Path $regPathWow6432) -and $is64bit) {

  Write-Host 'Uninstalling the 32-bit version before installing the 64-bit version …'
  $uninstallString = (Get-ItemProperty -Path $regPathWow6432).UninstallString
  Uninstall-ChocolateyPackage 'filezilla 32-bit' 'exe' '/S' $uninstallString
}

Install-ChocolateyPackage $packageName $fileType $silentArgs $url $url64bit `
  -validExitCodes $validExitCodes
