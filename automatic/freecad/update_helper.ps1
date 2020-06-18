
function Get-FreeCad {
param(
  [string]$Title,
  [string]$kind = 'stable',
  [int]$filler = "0"
)
  $mobile = @{$true="portable";$false="installer"}[($kind -eq 'portable')]; $portable = @{$true="vc14.x-x86_64";$false="$mobile"}[($kind -eq 'dev')]
  $try = (($download_page.Links | ? href -match "CAD\-|\.[\dA-Z]+\-WIN" | select -First 1 -expand href).Split("/")[-1]).Split(".")[-1]
  $ext = @{$true='7z';$false='exe'}[( $kind -match 'dev' ) -or ( $portable -match 'portable' )]
  $re32 = "(WIN)\-x32\-($portable)\.$ext";
  $re64 =  @{$true="(WIN|Win)\-(Conda|x64)(\-|_)$portable+(\.$ext)$";$false="(WIN)\-x64\-($portable)\.$ext$"}[( $kind -match 'dev' )]
  $url32 = $download_page.Links | ? href -match $re32 | select -first 1 -expand href
  $url64 = $download_page.Links | ? href -match $re64 | select -first 1 -expand href
  if (![string]::IsNullOrEmpty($url64) ){
  $checking = (($url64.Split('\/'))[-1]) -replace($re64,'') -replace('\-','.'); $version = ( Get-Version $checking ).Version
  } else { $version = "0.0.0";	$url64 = "/FreeCAD/FreeCAD/releases/download/0.19_pre/FreeCADLibs_12.1.4_x64_VC15.7z"; Write-Warning "No Version has been found." }
  switch ($kind) {
      'portable' {
          $PackageName  = "$Title.$kind"
          $Title = "$Title (Portable)"
      }
      default {
          $PackageName  = "$Title"
          $Title = "$Title"
      }
  }
  # Check if version is using a revision and build correctly
  if ( ($version.Build) -match "\d{5}" ) {
    [version]$version = ( ( ($version.Major),($version.Minor),($filler),($version.Build) ) -join "." )
  }
    $vert = @{$true="$version-$kind";$false="$version"}[( $kind -eq 'dev' )]
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
