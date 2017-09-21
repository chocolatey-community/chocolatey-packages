$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
. "$toolsDir\helpers.ps1"

$data = GetDownloadInformation -toolsPath $toolsDir
$destinationFolder = GetInstallDirectory -toolsPath $toolsDir

$packageArgs = @{
  PackageName = 'tor-browser'
  FileFullPath = Join-Path $env:TEMP "tor-browserInstall.exe"
  Url = $data.URL
  Checksum = $data.Checksum
  ChecksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

Write-Output "Installing $($packageArgs.PackageName) with language code: '$($data.Locale)'..."

Start-Process -Wait $packageArgs.FileFullPath -ArgumentList '/S', "/D=$destinationFolder"

Remove-Item  $packageArgs.FileFullPath -Force -ea 0

# Create .ignore files for exe’s
Get-ChildItem -Path $destinationFolder -Recurse | Where {
  $_.Extension -eq '.exe'} | % {
  New-Item $($_.FullName + '.ignore') -Force -ItemType file
# Suppress output of New-Item
} | Out-Null

$desktop = [System.Environment]::GetFolderPath('Desktop')

Install-ChocolateyShortcut `
  -ShortcutFilePath "$desktop\Tor Browser.lnk" `
  -TargetPath "$toolsDir\tor-browser\Browser\firefox.exe" `
  -WorkingDirectory "$toolsDir\tor-browser\Browser"

# set NTFS modify file permissions to $toolsDir\tor-browser\ for user account that installed the package
$WhoAmI=whoami
$Acl = Get-Acl "$toolsDir\tor-browser"
$Ar = New-Object  system.security.accesscontrol.filesystemaccessrule($WhoAmI,"Modify",'ContainerInherit,ObjectInherit', 'None', "Allow")
$Acl.SetAccessRule($Ar)
Set-Acl "$toolsDir\tor-browser" $Acl
