
function Get-FreeCad {
param(
  [string]$Title,
  [string]$kind = 'stable',
  [int]$filler = "0",
  [string]$uri = $releases,
  [string]$ScriptLocation = $PSScriptRoot
)
  $download_page = Invoke-WebRequest -Uri $uri -UseBasicParsing

  switch ($kind) {
    'dev' {
      $mobile = "Windows"
      $ext = "7z"
      $re64 = "(FreeCAD_weekly-builds)?((\-\d{2,6})+)?(\-conda)?(\-${mobile})(\-|.)?(x\d{2}_\d{2}\-)?(py\d{2,5})?(\.$ext)$"
      $url64 = ( $download_page.Links | ? href -match $re64 | Select-Object -First 1 -ExpandProperty 'href' )
      "url64 -$url64-" | Write-Warning
      $PackageName  = "$Title"
      $Title        = "$Title"
      # Now to get the newest Revision from url64
      $veri = ((($url64 -split('\/'))[-1]) -replace( "(x\d{2})|(_\d{2}\-py\d{2,5})|(\-)?([A-z])+?(\-)|(\.$ext)", ''))
      "veri -$veri-" | Write-Warning
      $DevRevision,$year,$month,$day = (($veri -replace('\-','.') ) -split('\.'))
      "Standard Development Versioning for $DevRevision dated ${month}-${day}-${year}" | Write-Warning
      [version]$version = ( ( ($DevRevision),($year),($month),($day) ) -join "." )
    $vert = "${version}-${kind}"
    }
    'portable' {
      $mobile = "portable"
      $ext = "zip"
      $re64 = "(FreeCAD\-)((\d+)?(\.))+?(\d)?(\-)(WIN)(\-)?(x\d{2})\-(${mobile})(\-|.)?(\d+)?(\.${ext})$"
      $url64 = ( $download_page.Links | ? href -match $re64 | Sort-Object -Property 'href' -Descending | Select-Object -First 1 -ExpandProperty 'href' )
      $vert = "$version"
      $PackageName  = "$Title.$kind"
      $Title        = "$Title (Portable)"
      [version]$version = ( Get-Version (($url64.Split('\/'))[-1]) ).Version
    }
    'stable' {
      $mobile = "installer"
      $ext = "exe"
      $re64 = "(FreeCAD\-)((\d+)?(\.))+?(\d)?(\-)(WIN)(\-)?(x\d{2})\-(${mobile})(\-|.)?(\d+)?(\.${ext})$"
      $url64 = ( $download_page.Links | ? href -match $re64 | Sort-Object -Property 'href' -Descending | Select-Object -First 1 -ExpandProperty 'href' )
      $vert = "$version"
      $PackageName  = "$Title"
      $Title        = "$Title"
      [version]$version = ( Get-Version (($url64.Split('\/'))[-1]) ).Version
    }
  }
  
  # check in place to prevent cross call talk from sequentional 
  if ($kind -notmatch 'dev') {
    # Check if version is using a revision and build correctly
    if (($version.Build) -match "\d{1,5}") {
      $vert = ( ( ($version.Major),($version.Minor),($filler),($version.Build) ) -join "." )
    }
    # This is to update the version when the fileName/url64 changes in the future
    if (($version.Revision) -ne 0) {
      # Due to the Get-Version rendering the revision as a negative
      $revision = [math]::Abs( $version.Revision )
      "Versioning update $revision for -$url64-" | Write-Warning
      $vert = ( ( ($version.Major),($version.Minor),($version.Build),($revision) ) -join "." )
    }
  }
  
 	$package = @{
    PackageName  = ($PackageName).ToLower()
    Title        = $Title
    URL64        = $PreUrl + $url64
    Version      = $vert
    fileType     = ($url64.Split("/")[-1]).Split(".")[-1]
    }
   # Due to the dev package being pre-release software we are removing ReleaseNotes
    if ($kind -ne "dev") {
      $package.Add( "ReleaseNotes", "https://www.freecadweb.org/wiki/Release_notes_$($version.Major).$($version.Minor)" )
    }
	
return $package
}
