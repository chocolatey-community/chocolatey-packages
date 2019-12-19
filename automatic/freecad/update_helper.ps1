

function Get-FreeCad {
param(
    [string]$bitness,
    [string]$Title,
    [string]$kind
)


  $download_page = Invoke-WebRequest -UseBasicParsing -Uri $releases
  $try = (($download_page.Links | ? href -match "CAD\-|\.[\dA-Z]+\-WIN" | select -First 1 -expand href).Split("/")[-1]).Split(".")[-1]
  $ext = @{$true='7z';$false='exe'}[( $kind -match 'dev' )]
  $ver = @{$true="DEV";$false="(\d\.\d+\.\d+\.\d+[Z-a].\d)"}[( $kind -match 'dev' )]
  $re32 = "(WIN)\-x32\-(installer)\.$ext"
  $re64 =  @{$true="(x64_Conda_Py3QT5-Win).+(\.$ext)$";$false="(WIN)\-x64\-(installer)\.$ext$"}[( $kind -match 'dev' )]
  $url32 = $download_page.Links | ? href -match $re32 | select -first 1 -expand href
  $url64 = $download_page.Links | ? href -match $re64 | select -first 1 -expand href
  $checking = (($url64.Split('\/'))[-1]) -replace('WIN-x64-installer.$ext','')
  $version = ( Get-Version $checking ).Version

  if ( $kind -eq 'dev' ) {
    $vert = "$version-$kind";
    $Title = $Title + '-' + $kind
  } else {
    $vert = $version;
    $Title = $Title;
  }
  
 	$package = @{
		Title        = $Title
		URL64        = $PreUrl + $url64
		Version      = $vert
        fileType     = ($url64.Split("/")[-1]).Split(".")[-1]
		ReleaseNotes = "https://www.freecadweb.org/wiki/Release_notes_$($version.Major).$($version.Minor)"
	}

    if (![string]::IsNullOrEmpty($url32)) {
        $package.Add( "URL32", $PreUrl + $url32 )
	}
return $package
} 