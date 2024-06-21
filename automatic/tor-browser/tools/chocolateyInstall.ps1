$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
. "$toolsDir\helpers.ps1"

$destinationFolder = GetInstallDirectory -toolsPath $toolsDir

$packageArgs = @{
  PackageName  = 'tor-browser'
  FileType     = 'exe'
  Url          = 'https://archive.torproject.org/tor-package-archive/torbrowser/13.5/tor-browser-windows-i686-portable-13.5.exe'
  Url64        = 'https://archive.torproject.org/tor-package-archive/torbrowser/13.5/tor-browser-windows-x86_64-portable-13.5.exe'
  Checksum     = 'dde2661a3c9a56f39b89d58bc98aabda381ad7990430d49687ded3de9473ad3a'
  Checksum64   = '1258cea4c6a5576bc6e1dac39a67f3f9ad8dbd64657ba94c7506ce527476000a'
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
