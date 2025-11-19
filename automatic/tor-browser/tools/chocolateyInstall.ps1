$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
. "$toolsDir\helpers.ps1"

$destinationFolder = GetInstallDirectory -toolsPath $toolsDir

$packageArgs = @{
  PackageName  = 'tor-browser'
  FileType     = 'exe'
  Url          = 'https://archive.torproject.org/tor-package-archive/torbrowser/15.0.2/tor-browser-windows-i686-portable-15.0.2.exe'
  Url64        = 'https://archive.torproject.org/tor-package-archive/torbrowser/15.0.2/tor-browser-windows-x86_64-portable-15.0.2.exe'
  Checksum     = 'a44b527ceaaa6f94cfe6805fa9039ad8c45040dfa6bd705ff0075eaf34303b3c'
  Checksum64   = 'c9ea87f9bfe704b83a1c8af80442f41187620729dbc1468147595ab7f1c819d0'
  ChecksumType = 'sha256'
  SilentArgs   = "/S","/D=$destinationFolder"
}

Install-ChocolateyPackage @packageArgs

# Create .ignore files for exe’s
Get-ChildItem -Path $destinationFolder -Recurse | Where-Object {
  $_.Extension -eq '.exe' } | ForEach-Object {
  New-Item $($_.FullName + '.ignore') -Force -ItemType file
  # Suppress output of New-Item
} | Out-Null

$desktop = [System.Environment]::GetFolderPath('Desktop')

Install-ChocolateyShortcut `
  -ShortcutFilePath "$desktop\Tor Browser.lnk" `
  -TargetPath "$toolsDir\tor-browser\Browser\firefox.exe" `
  -WorkingDirectory "$toolsDir\tor-browser\Browser"

# set NTFS modify file permissions to $toolsDir\tor-browser\ for user account that installed the package
$WhoAmI = whoami
$Acl = Get-Acl "$toolsDir\tor-browser"
$Ar = New-Object  system.security.accesscontrol.filesystemaccessrule($WhoAmI, "Modify", 'ContainerInherit,ObjectInherit', 'None', "Allow")
$Acl.SetAccessRule($Ar)
Set-Acl "$toolsDir\tor-browser" $Acl
