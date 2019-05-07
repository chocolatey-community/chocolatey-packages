

function Get-FreeCad {
param(
    [string]$bitness,
    [string]$Title,
    [string]$kind
)


  $download_page = Invoke-WebRequest -UseBasicParsing -Uri $releases
  $try = (($download_page.Links | ? href -match "CAD\-|\.[\dA-Z]+\-WIN" | select -First 1 -expand href).Split("/")[-1]).Split(".")[-1]
  Write-Host "try -$try-"
  $ext = @{$true='7z';$false='exe'}[( $kind -match 'dev' )]

  $ver = @{$true="DEV";$false="CAD\-|\.[\dA-Z]+\-WIN"}[( $kind -match 'dev' )]
  $re32 = "x86.*\.$ext$"
  $re64 =  @{$true="x64_Conda_Py3QT5.*\.$ext$";$false="x64.*\.$ext$"}[( $kind -match 'dev' )]
  $url32 = $download_page.Links | ? href -match $re32 | select -first 1 -expand href
  $url64 = $download_page.Links | ? href -match $re64 | select -first 1 -expand href
  if ( $ver -eq 'DEV' ) {
  $verRe32 = $verRe64 = "_"
  } else {
  $verRe32 = $verRe64 = "-"
  }
  ( Get-Version $url32 -Delimiter $verRe32 ) -match $regex | Out-Null
  $version32 = $Matches[0]
  ( Get-Version $url64 -Delimiter $verRe64 ) -match $regex | Out-Null
  $version64 = $Matches[0]

  if ( $version32 -eq $version64 ) {
  $version = $version32
  } 
  if ( $version32 -ne $version64 ) {
  $version = $version64
  }

  [version]$version32 = $url -split "$verRe32" | select -last 1 -skip 1

  if ( $kind -eq 'dev' ) {
    $vert = "$version-$kind";
    $Title = $Title + '-' + $kind
  } else {
    $vert = $version;
    $Title = $Title;
  }
  

 	@{
		Title        = $Title
		URL32        = $PreUrl + $url32
		URL64        = $PreUrl + $url64
		Version      = $vert
    fileType     = ($url32.Split("/")[-1]).Split(".")[-1]
		ReleaseNotes = "https://www.freecadweb.org/wiki/Release_notes_$($version32.Major)$($version32.Minor)"
	}
} 
