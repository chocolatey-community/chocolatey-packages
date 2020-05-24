
function Compare-Hashes {
param (
  [string]$my_path = "$PSScriptRoot",
  [string]$reg_chksum = '\bchecksum\b',
  [string]$checksumType = '\bchecksumType\b'
)
$global:au_force=$gud = $false;
$current_checksumType = (gi "$my_path\tools\chocolateyInstall.ps1" | sls $checksumType) -split "=|'" | Select -Last 1 -Skip 1
$current_checksum = (gi "$my_path\tools\chocolateyInstall.ps1" | sls $reg_chksum) -split "=|'" | Select -Last 1 -Skip 1
if ($current_checksumType -eq "SHA512"){ $characters = "128" }; if ($current_checksumType -eq "SHA256"){ $characters = "64"}
if ($current_checksum.Length -ne $characters) { throw "Can't find current checksum" }
$remote_checksum  = Get-RemoteChecksum $url -Algorithm $current_checksumType
 if ($current_checksum -ne $remote_checksum) {
  Write-Host 'Remote checksum is different then the current one, forcing update'
  $global:au_old_force = $global:au_force; $global:au_force = $true; $gud = $true
 }
return $gud
}

function Get-ETagIfChanged {
param(
  [string]$url,
  [string]$tag = "Content-Length",
  [string]$packageName = "$PSScriptRoot\info"
) 
 (Compare-Hashes) | Out-Null
 if (!(Test-Path "$packageName")) {
   New-Item "$PSScriptRoot$packageName" -ItemType file
 }  
 if (($global:au_Force -ne $true) -and (Test-Path "$packageName")) {
  $existingETag = Get-Content "$packageName" -Encoding "UTF8" | Select -First 1 | Foreach { $_ -split '\|' } | Select -First 1
 } else {
  $existingETag = $null
 }
 $etag = Invoke-WebRequest -Method Head -Uri $url -UseBasicParsing
 $etag = $etag | Foreach { $_.Headers.$tag }
 if ($etag -eq $existingETag) { return $null }
return $etag
}
Set-Alias GetETagIfChanged Get-ETagIfChanged

function Get-ResultInformation {
param(
  [string]$url32,
  [string]$file = "install.exe",
  [string]$version = "FileVersion",
  [string]$algorithm = "SHA512"
)
$dest = "$env:TEMP\$file"
Invoke-WebRequest -UseBasicParsing -Uri $url32 -OutFile $dest
$version = Get-Item $dest | Foreach { $_.VersionInfo.$version -replace '^(\d+(\.[\d]+){1,3}).*', '$1' }
$version = ( Get-FixVersion $version )

 $result = @{
  URL32          = $url32
  Version        = $version
  Checksum32     = Get-FileHash $dest -Algorithm $algorithm | Foreach Hash
  ChecksumType32 = $algorithm
 }
Remove-Item -Force $dest
return $result
}
Set-Alias GetResultInformation Get-ResultInformation
