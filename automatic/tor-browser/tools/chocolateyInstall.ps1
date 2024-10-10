$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
. "$toolsDir\helpers.ps1"

$destinationFolder = GetInstallDirectory -toolsPath $toolsDir

$packageArgs = @{
  PackageName  = 'tor-browser'
  FileType     = 'exe'
  Url          = 'https://archive.torproject.org/tor-package-archive/torbrowser/13.5.7/tor-browser-windows-i686-portable-13.5.7.exe'
  Url64        = 'https://archive.torproject.org/tor-package-archive/torbrowser/13.5.7/tor-browser-windows-x86_64-portable-13.5.7.exe'
  Checksum     = '68cc3e9a72e256ec60c7d702f414cf5c0cd9a77dee7c79b9ad0da6bddfd43606'
  Checksum64   = 'b62a289d756a77a7db1e5b818f9fdb094a0d7dcb19b0fdaf8e8b4350be0530d7'
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
