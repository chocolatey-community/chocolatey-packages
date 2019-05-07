

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
  #write-host "ext -$ext-"
  # $bit = @{$true='x86';$false='x64'}[( $bitness -match '32' )]

  $ver = @{$true="DEV";$false="CAD\-|\.[\dA-Z]+\-WIN"}[( $kind -match 'dev' )]
  #write-host "ver -$ver-"
  $re32 = "x86.*\.$ext$"
  # Changed Search for x64 from "x64_dev_win.*\.$ext$" to "x64_Conda_Py3QT5.*\.$ext$"
  $re64 =  @{$true="x64_Conda_Py3QT5.*\.$ext$";$false="x64.*\.$ext$"}[( $kind -match 'dev' )]
  #write-host "re32 -$re32-"
  #write-host "re64 -$re64-"
  $url32 = $download_page.Links | ? href -match $re32 | select -first 1 -expand href
  $url64 = $download_page.Links | ? href -match $re64 | select -first 1 -expand href
  #write-host "url64 -$url64-"
  #write-host "O ver -$ver-"
  if ( $ver -eq 'DEV' ) {
  #write-host "A ver -$ver-"
  $verRe32 = $verRe64 = "_"
  } else {
  #write-host "B ver -$ver-"
  $verRe32 = $verRe64 = "-"
  }
  #Write-Host "verRe32 -$verRe32-"
  #Write-Host "verRe64 -$verRe64-"
  ( Get-Version $url32 -Delimiter $verRe32 ) -match $regex | Out-Null
  $version32 = $Matches[0]
  #Write-Host "A version32 -$version32-"
  ( Get-Version $url64 -Delimiter $verRe64 ) -match $regex | Out-Null
  $version64 = $Matches[0]
  #Write-Host "A version64 -$version64-"

  if ( $version32 -eq $version64 ) {
  #write-host "we are equal"
  $version = $version32
  } 
  if ( $version32 -ne $version64 ) {
  #write-host "we aren't equal"
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
  #Write-Host "vert -$vert-"
  

 	@{
		Title        = $Title
		URL32        = $PreUrl + $url32
		URL64        = $PreUrl + $url64
		Version      = $vert
        fileType     = ($url32.Split("/")[-1]).Split(".")[-1]
		ReleaseNotes = "https://www.freecadweb.org/wiki/Release_notes_$($version32.Major)$($version32.Minor)"
	}
} 
