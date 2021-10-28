
function Get-HeadersIfChanged() {
param(
    [string]$url,
    [string]$file,
    [ValidateSet("portable", "stable", "dev")]
    [string]$kind
)
# Check for the info file and if not create it
  if (!(Test-Path $file)) {
	New-Item $file -ItemType file
  }
# Read file when existing and not forced else info is null
  if (($global:au_Force -ne $true) -and (Test-Path $file)) {
    $existingETag = ( Get-Content $file -Raw | ConvertFrom-Json )
  }  else {
    $existingETag = @{}
  }
# Retrieve info from file
  $etag = Invoke-WebRequest -Method Head -Uri $url -UseBasicParsing
  # $etag = $etag | Foreach { $_.Headers.ETag }
  $etag = $etag | Foreach { $_.Headers["Content-Length"] }
# Compare web info to file and return true
  if ($etag -ne $existingETag.$kind) {
    foreach($line in $existingETag){
        $existingETag.$kind = $line.$kind -replace("(\d+)" , $etag)
    }
    $existingETag | ConvertTo-Json -depth 32| set-content $file
	return $true
  }  
# Return info if different
  return $false
}

function Get-FreeCad {
param(
    [string]$Title,
    [string]$kind = 'stable',
    [int]$filler = "0",
    [string]$uri = $releases
  )
  $download_page = Invoke-WebRequest -Uri $uri -UseBasicParsing
  $mobile = @{$true = "portable"; $false = "installer" }[($kind -eq 'portable')]; $portable = @{$true = "vc(17|14)\.x\-x86(\-|_)64"; $false = "$mobile" }[($kind -eq 'dev')]
  $try = (($download_page.Links | ? href -match "CAD\-|\.[\dA-Z]+\-WIN" | select -First 1 -expand href).Split("/")[-1]).Split(".")[-1]
  $ext = @{$true = '7z'; $false = 'exe' }[( $kind -match 'dev' ) -or ( $portable -match 'portable' )]
  $re32 = "(WIN)\-x32\-($portable)\.$ext";
  # cybrwshl use of (\-[0-9])? regex updated to (\-\d+)? for installer with possible digit(s) before extension
  $re64 = @{$true = "(WIN|Win)\-(LPv\d+\.\d+\.\d+|Conda|x64)(\-|_)($portable)(\-|.)?(\d+)?(\.$ext)$"; $false = "(WIN)\-x64\-($portable)(\-|.)?(\d)?\.$ext$" }[( $kind -match 'dev' )]
  $url32 = $download_page.Links | ? href -match $re32 | select -first 1 -expand href
  $url64 = $download_page.Links | ? href -match $re64 | select -first 1 -expand href
  # Logic to find filler value from url
  $fill = (($url64.Split('\/'))[-2]).Split('.')[-1]
  if ( (!([string]::IsNullOrEmpty($fill) ) ) -and ($fill -is [int]) ) {
    Write-Warning "fill -$fill-"
    if ($fill -ge $filler) { $filler = $fill }
  }
  $checking = (($url64.Split('\/'))[-1]) -replace ($re64, '') -replace ('\-', '.'); $version = ( Get-Version $checking ).Version
  # Version Matching for all kind except dev since it is only 64bit
  if ($kind -ne 'dev') {
    $32bitchk = (($url32.Split('\/'))[-1]) -replace ($re32, '') -replace ('\-', '.'); $ver32 = ( Get-Version $32bitchk ).Version
    if ($ver32 -ne $version) {
      Write-Warning "ver32 -$ver32- version -$version-"
      # This is commented due to the added Notes in the Readme
      #	    $url32 = $null
    }
  }
  switch ($kind) {
    'portable' {
      $PackageName = "$Title.$kind"
      $Title = "$Title (Portable)"
    }
    default {
      $PackageName = "$Title"
      $Title = "$Title"
    }
  }
  # Check if version is using a revision and build correctly
  if ( ($version.Build) -match "\d{5}" ) {
    [version]$version = ( ( ($version.Major), ($version.Minor), ($filler), ($version.Build) ) -join "." )
  }
  $vert = @{$true = "$version-$kind"; $false = "$version" }[( $kind -eq 'dev' )]
# The url64 should always be valid
$test = (Get-HeadersIfChanged -url "${PreUrl}${url64}" -file "${PSScriptRoot}\freecad.info" -kind $kind)
if (($test -eq $true) -and ($kind -ne 'dev')) {
	$vert = (Get-FixVersion $vert)
}
 	$package = @{
    PackageName  = ($PackageName).ToLower()
    Title        = $Title
    URL64        = $PreUrl + $url64
    Version      = $vert
    fileType     = ($url64.Split("/")[-1]).Split(".")[-1]
    ReleaseNotes = "https://www.freecadweb.org/wiki/Release_notes_$($version.Major).$($version.Minor)"
  }
  if (![string]::IsNullOrEmpty($url32)) { $package.Add( "URL32", $PreUrl + $url32 ) }
  return $package
}
