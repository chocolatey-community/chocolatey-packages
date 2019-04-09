$PSScriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Definition
$fileFullPath = Join-Path $PSScriptRoot 'keepass_2.x_langfiles.7z'

function Get-KeePassInstallLocation {
  @(
    'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\KeePassPasswordSafe2_is1',
    'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\KeePassPasswordSafe2_is1'
  ) | foreach {

    if (Test-Path $_) {
      return (Get-ItemProperty $_).InstallLocation
    }
  }
}

$destination = Get-KeePassInstallLocation

if (!$destination) {
  throw 'KeePass is not installed. Please install it before installing this package.'
}

Get-ChocolateyUnzip $fileFullPath "$destination\Languages"
rm "$extractPath\*.7z" -ea 0
