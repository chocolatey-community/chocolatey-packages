
function Get-FreeCad {
param(
  [string]$Title,
  [string]$kind = 'stable',
  [int]$filler = "0",
  [string]$uri = $releases
)
  $download_page = Invoke-WebRequest -Uri $uri -UseBasicParsing
  $mobile = @{$true="portable";$false="installer"}[($kind -eq 'portable')]
  $portable = @{$true="vc(19|17|14)\.x\-x86(\-|_)64";$false="$mobile"}[($kind -eq 'dev')]
  $ext = @{$true='7z';$false='exe'}[( $kind -match 'dev' ) -or ( $portable -match 'portable' )]
  # cybrwshl use of (\-[0-9])? regex updated to (\-\d+)? for installer with possiblity of any number of digit(s) before extension
  $re64 =  @{$true="(WIN|Win)\-(LPv\d+\.\d+\.\d+|Conda|x64)(\-|_)($portable)(\-|.)?(\d+)?(\.$ext)$";$false="(WIN)\-x64\-($portable)(\-|.)?(\d+)?\.$ext$"}[( $kind -match 'dev' )]
  # FreeCad Website only makes mention of a 64-bit version for download as of 2022-2-16
  $url64 = @{$true=( $download_page.Links | ? href -match $re64 | Select-Object -First 1 -ExpandProperty 'href' )`
  ;$false=( $download_page.Links | ? href -match $re64 | Sort-Object -Property 'href' -Descending | Select-Object -First 1 -ExpandProperty 'href' )}[($kind -eq 'dev')]
  # Logic to find filler value from url
  $fill = (($url64.Split('\/'))[-2]).Split('.')[-1]
  if ( (!([string]::IsNullOrEmpty($fill) ) ) -and ($fill -is [int]) ) {
    "fill -$fill-" | Write-Warning
    if ($fill -ge $filler) { $filler = $fill }
  }
  "url64 -${PreUrl}${url64}-" | Write-Warning
  $chking = (($url64.Split('\/'))[-1])
  $checking = $chking -replace($re64,'') -replace('\-','.')
  "version check -$checking-" | Write-Warning
  $version = ( Get-Version $checking ).Version
  # Check if version is using a revision and build correctly
  if ( ($version.Build) -match "\d{5}" ) {
    [version]$version = ( ( ($version.Major),($version.Minor),($filler),($version.Build) ) -join "." )
  }
  $vert = @{$true="$version-$kind";$false="$version"}[( $kind -eq 'dev' )]
  # Due to Non Uniform Releases of the package in the past
  $NonUniformRegex = "(?:\-)(\d+)(?:.${ext})"
  if (($chking -match $NonUniformRegex) -and ($kind -ne 'dev')) { if (!([string]::IsNullOrEmpty( $Matches[1] ))) { $digits = $Matches[1] } "digits -$digits-" | Write-Warning }
  # If digits are found in the fileName they will be addded to the version number
  # This approach is done due a four segment version needed for Get-FixVersion
  if ((!([string]::IsNullOrEmpty($digits) ) ) -and ($digits -match "(\d+)")) {  $vert = "${vert}.${digits}" }
  "vert -$vert-" | Write-Warning
  switch ($kind) {
    'portable' {
      $PackageName  = "$Title.$kind"
      $Title        = "$Title (Portable)"
    }
    default {
      $PackageName  = "$Title"
      $Title        = "$Title"
    }
  }
 	$package = @{
    PackageName  = ($PackageName).ToLower()
    Title        = $Title
    URL64        = $PreUrl + $url64
    Version      = $vert
    fileType     = ($url64.Split("/")[-1]).Split(".")[-1]
    ReleaseNotes = "https://www.freecadweb.org/wiki/Release_notes_$($version.Major).$($version.Minor)"
	}
return $package
}
