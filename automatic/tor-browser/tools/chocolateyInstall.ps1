$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
. "$toolsDir\helpers.ps1"

$destinationFolder = GetInstallDirectory -toolsPath $toolsDir

$packageArgs = @{
  PackageName  = 'tor-browser'
  FileType     = 'exe'
  Url          = 'https://www.torproject.org/dist/torbrowser/12.0.4/torbrowser-install-12.0.4_ALL.exe'
  Url64        = 'https://www.torproject.org/dist/torbrowser/12.0.4/torbrowser-install-win64-12.0.4_ALL.exe'
  Checksum     = '11b01f5065d360d0955bad51498555fe48502749cc111a44976436b61d2ba2bd'
  Checksum64   = 'ddad37d7324cc8ba3633528f8df1e7a27c0df11aa48d27c202a925bfefb4b390'
  ChecksumType = 'sha256'
  SilentArgs   = "/S","/D=$destinationFolder"
}

Install-ChocolateyPackage @packageArgs

# Create .ignore files for exeâ€™s
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
