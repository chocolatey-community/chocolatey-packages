$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
. "$toolsDir\helpers.ps1"

$destinationFolder = GetInstallDirectory -toolsPath $toolsDir

$packageArgs = @{
  PackageName  = 'tor-browser'
  FileType     = 'exe'
  Url          = 'https://www.torproject.org/dist/torbrowser/12.5.1/torbrowser-install-12.5.1_ALL.exe'
  Url64        = 'https://www.torproject.org/dist/torbrowser/12.5.1/torbrowser-install-win64-12.5.1_ALL.exe'
  Checksum     = 'b2592cc9b27f5ce81f5744662a6119d4db627f475316ac7a1cf02b52cd326395'
  Checksum64   = '82edb937dc64dc647aca0c93ecbfc5ee0a657eb917d29f9b3ef2a9f08558ca5b'
  ChecksumType = 'sha256'
  SilentArgs   = "/S","/D=$destinationFolder"
}

Install-ChocolateyPackage @packageArgs

# Create .ignore files for exes
Get-ChildItem -Path $destinationFolder -Recurse | Where-Object {
  $_.Extension -eq '.exe' } | ForEach-Object {
  New-Item $($_.FullName + '.ignore') -Force -ItemType file
  # Suppress output of New-Item
} | Out-Null

$desktop = [System.Environment]::GetFolderPath('Desktop')

Install-ChocolateyShortcut `
  -ShortcutFilePath "$desktop\Tor Browser.lnk" `
  -TargetPath "$destinationFolder\Browser\firefox.exe" `
  -WorkingDirectory "$destinationFolder\Browser"

# set NTFS modify file permissions to $destinationFolder for user account that installed the package
$WhoAmI = whoami
$Acl = Get-Acl $destinationFolder
$Ar = New-Object  system.security.accesscontrol.filesystemaccessrule($WhoAmI, "Modify", 'ContainerInherit,ObjectInherit', 'None', "Allow")
$Acl.SetAccessRule($Ar)
Set-Acl $destinationFolder $Acl
