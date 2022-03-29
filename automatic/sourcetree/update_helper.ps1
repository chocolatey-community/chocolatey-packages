
function Get-JavaSiteUpdates {
  param(
    [string]$Package,
    [string]$Title,
    [int]$revision = 20 # This is updatable outside the function should the number need to go higher
  )
  
# We are using this url to test for new versions since it is updated with the latest version as soon as it is available
$releaseNotesURL = "https://product-downloads.atlassian.com/software/sourcetree/windows/ga/ReleaseNotes_<version>.html"
# Next we will read the last good version from the nuspec file
$PreVersion = ([xml](Get-Content "$PSScriptRoot\sourcetree.nuspec")).package.metadata.version
#  Now to split the PreVersion for the loops
[int]$z,[int]$y,[int]$x = $PreVersion -split('\.')
for($a=$z; $a -lt $revision;$a++){
  for($b=$y; $b -lt $revision;$b++){
    for($c=$x; $c -lt $revision;$c++){
      $testing = $releaseNotesURL -replace( "<version>" ,  -join($a, ".", $b, ".", $c ) )
      try {
        $url = Invoke-WebRequest -UseBasicParsing -Uri $testing | Select-Object StatusCode
      }
      catch {
        if (!([string]::IsNullOrEmpty( $url )) ) {
          # This will get the number that fails by subtracting 1 from c we will get the latest version
          $version = -join($a, ".", $b, ".", ($c -1) )
          $version | Write-Warning
          # This is an emergency stop of all for loops
          $revision = 0
        }
      }
    }
  }
}

  @{
    PackageName  = $Package
	  Title        = $Title
	  Version	     = $version
	  URL32		     = "https://product-downloads.atlassian.com/software/sourcetree/windows/ga/SourcetreeEnterpriseSetup_${version}.msi"
	  ReleaseNotes = "https://product-downloads.atlassian.com/software/sourcetree/windows/ga/ReleaseNotes_$version.html"
  }
}
