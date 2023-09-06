function Get-FreeCad {
  [CmdletBinding()]
  param(
    # Release-type of FreeCAD to return
    [ValidateSet("stable", "dev", "portable")]
    [string]$Kind = 'stable'
  )

  $LatestRelease = if ($Kind -eq "dev") {
    Get-GitHubRelease -Owner "Freecad" -Name "Freecad-Bundle" -TagName "weekly-builds"
  } else {
    Get-GitHubRelease -Owner FreeCAD -Name FreeCAD
  }

  $Title = "FreeCAD"
  $PackageName = $Title.ToLower()

  switch ($Kind) {
    'dev' {
      $ext = "7z"
      $re64 = "(FreeCAD_weekly-builds)?((\-\d{2,6})+)?(\-conda)?\-Windows(\-|.)?(x\d{2}_\d{2}\-)?(py\d{2,5})?(\.$ext)$"
      $url64 = $LatestRelease.assets.Where{$_.name -match $re64}[0].browser_download_url

      # Now to get the newest Revision from url64
      $veri = ((($url64 -split('\/'))[-1]) -replace( "(x\d{2})|(_\d{2}\-py\d{2,5})|(\-)?([A-z])+?(\-)|(\.$ext)", ''))

      $DevRevision,$year,$month,$day = (($veri -replace('\-','.') ) -split('\.'))

      [version]$version = ( ( ($DevRevision),($year),($month),($day) ) -join "." )
      $FinalVersion = "${version}-dev"
    }
    'portable' {
      $ext = "zip"
      $re64 = "(FreeCAD\-)((\d+)?(\.))+?(\d)?(\-)(WIN)(\-)?(x\d{2})\-portable(\-|.)?(\d+)?(\.${ext})$"
      $url64 = $LatestRelease.assets.Where{$_.name -match $re64}.browser_download_url

      if ($null -eq $url64) {
        Write-Warning "FreeCAD portable $($ext) was not found in GitHub release at '$($LatestRelease.html_url)'. Skipping portable package stream."
        return 'ignore'
      }

      $PackageName  = "$PackageName.portable"
      $Title        = "$Title (Portable)"
      [version]$version = $LatestRelease.tag_name.TrimStart("v")
    }
    'stable' {
      $ext = "exe"
      $re64 = "(FreeCAD\-)((\d+)?(\.))+?(\d)?(\-)(WIN)(\-)?(x\d{2})\-installer(\-|.)?(\d+)?(\.${ext})$"
      $url64 = $LatestRelease.assets.Where{$_.name -match $re64}.browser_download_url

      [version]$version = $LatestRelease.tag_name.TrimStart("v")
    }
  }

  # check in place to prevent cross call talk from sequentional
  if ($kind -ne 'dev') {
    # Check if version is using a revision and build correctly
    if (($version.Build) -match "\d{1,5}") {
      $FinalVersion = ( ( ($version.Major),($version.Minor),(0),($version.Build) ) -join "." )
    }
    # This is to update the version when the fileName/url64 changes in the future
    if (($version.Revision) -ne 0) {
      # Due to the Get-Version rendering the revision as a negative
      $revision = [math]::Abs( $version.Revision )

      $FinalVersion = ( ( ($version.Major),($version.Minor),($version.Build),($revision) ) -join "." )
    }
  }

 	$package = @{
    PackageName  = $PackageName
    Title        = $Title
    URL64        = $url64
    Version      = $FinalVersion
    fileType     = $ext
  }

  # Due to the dev package being pre-release software we are removing ReleaseNotes
  if ($kind -ne "dev") {
    $package.Add( "ReleaseNotes", "https://www.freecadweb.org/wiki/Release_notes_$($version.Major).$($version.Minor)" )
  }

  return $package
}
