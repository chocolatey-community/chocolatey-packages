
function GetETagIfChanged() {
  param([string]$url)

  if (!(Test-Path $PSScriptRoot\info)) {
	New-Item $PSScriptRoot\info -ItemType file
  }
  
  if (($global:au_Force -ne $true) -and (Test-Path $PSScriptRoot\info)) {
    $existingETag = Get-Content "$PSScriptRoot\info" -Encoding "UTF8" | Select -First 1 | Foreach { $_ -split '\|' } | Select -First 1
  }
  else {
    $existingETag = $null
  }

  $etag = Invoke-WebRequest -Method Head -Uri $url -UseBasicParsing
  # $etag = $etag | Foreach { $_.Headers.ETag }
  $etag = $etag | Foreach { $_.Headers["Content-Length"] }
  if ($etag -eq $existingETag) { return $null }

  return $etag
}

function Compare-Hashes {
param (
	[string]$my_path = "$PSScriptRoot",
	[string]$reg_chksum = '\bchecksum\b'
)
	$gud = $false
	$current_checksum = (gi "$my_path\tools\chocolateyInstall.ps1" | sls $reg_chksum) -split "=|'" | Select -Last 1 -Skip 1
	if ($current_checksum.Length -ne 128) { throw "Can't find current checksum" }
	$remote_checksum  = Get-RemoteChecksum $url
	if ($current_checksum -ne $remote_checksum) {
		Write-Host 'Remote checksum is different then the current one, forcing update'
		$gud = $true
	}
return $gud
}

function Get-PaddingNumber {
	$tags= Invoke-WebRequest -Method Head -Uri $url -UseBasicParsing
	$date = $tags | Foreach { $_.Headers["Date"] }
	$lastChange = $tags | Foreach { $_.Headers["Last-Modified"] }
	$ts = New-TimeSpan -Start $lastChange -End $date
return $ts
}

function Get-FixedVersion {
param(
	[string]$new,
	[string]$etag,
	[string]$infoPath = "$PSScriptRoot\info"
)
$me = ( $MyInvocation.MyCommand ); $padVersion = "4.0.0.2"
$version = Get-Content $infoPath -Encoding "UTF8" | select -First 1 | Foreach { $_ -split '\|' } | select -Last 1
  if (($new -ge $padVersion) -and ($version -ge $new)) {
	if ([string]::IsNullOrEmpty($etag)) {
	$etag = Get-Content $infoPath -Encoding "UTF8" | Select -First 1 | Foreach { $_ -split '\|' } | Select -First 1
	} 
	if ( Compare-Hashes ) {
	$regex = @{$true=".{2}$";$false=""}[ ( (( $version -split "\.")[-1]) -match "\d{3}") ]
	$padding = @{$true=(( Get-PaddingNumber ).Days ).ToString("00");$false=""}[ ( (( $version -split "\.")[-1]) -match "\d{3}") ]
	$version = ($version -replace $regex ) + $padding
	}     
  } else {
   $version = $new
  }
return $version
}

function GetResultInformation() {
  param([string]$url32,[string]$file)

  $dest = "$env:TEMP\$file"
  Invoke-WebRequest -UseBasicParsing -Uri $url32 -OutFile $dest
  $version = Get-Item $dest | Foreach { $_.VersionInfo.FileVersion -replace '^(\d+(\.[\d]+){1,3}).*', '$1' }

  $result = @{
    URL32          = $url32
    Version        = Get-FixedVersion $version
    Checksum32     = Get-FileHash $dest -Algorithm "SHA512" | Foreach Hash
    ChecksumType32 = 'sha512'
  }
  Remove-Item -Force $dest
  return $result
}
