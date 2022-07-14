
function Get-FreeCad {
param(
  [string]$Title,
  [string]$kind = 'stable',
  [int]$filler = "0",
  [int]$freecadMinor = "21",
  [string]$uri = $releases,
  [string]$ScriptLocation = $PSScriptRoot
)
  
  $download_page = Invoke-WebRequest -Uri $uri -UseBasicParsing

  switch ($kind) {
    'dev' {
      $mobile = "Windows"
      $ext = "7z"
      $re64 = "(FreeCAD_weekly-builds)?((\-\d{2,6})+)?(\-conda)?(\-${mobile})(\-|.)?(x\d{2}_\d{2}\-)?(py\d{2})?(\.$ext)$"
      $url64 = ( $download_page.Links | ? href -match $re64 | Select-Object -First 1 -ExpandProperty 'href' )
      "url64 -$url64-" | Write-Warning
      $PackageName  = "$Title"
      $Title        = "$Title"
      # Now to get the newest Revision from url64
      $veri = ((($url64 -split('\/'))[-1]) -replace( "(x\d{2})|(_\d{2}\-py\d{2})|(\-)?([A-z])+?(\-)|(\.$ext)", ''))
      "veri -$veri-" | Write-Warning
      $DevRevision,$year,$month,$day = (($veri -replace('\-','.') ) -split('\.'))
      [version]$DevVersion = (( Get-Content "$ScriptLocation\freecad.json" | ConvertFrom-Json ).stable)
      if (($DevRevision -match "\d{5}") -and ($DevRevision -gt "29192")){
        "Revision is greater than it was on date 6/20/2022 which could mean a new version minor" | Write-Warning
        if ($freecadMinor -gt $DevVersion.Minor) {
          "Using -$freecadMinor- due passed value equal or larger than stable" | Write-Warning
        } else {
          "Going to increase the version minor by 1" | Write-Warning
          $freecadMinor = ($DevVersion.Minor + 1)
        }
        [version]$version = ( ( ($DevVersion.Major),($freecadMinor),($DevVersion.Build),($DevRevision) ) -join "." )
      } else {
        "Standard Versioning for $DevRevision dated ${month}-${day}-${year}" | Write-Warning
        [version]$version = ( ( ($DevVersion.Major),($DevVersion.Minor),($DevVersion.Build),($DevRevision) ) -join "." )
      }
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
    ReleaseNotes = "https://www.freecadweb.org/wiki/Release_notes_$($version.Major).$($version.Minor)"
	}
  
return $package
}
