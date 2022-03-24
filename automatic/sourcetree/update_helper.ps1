function Get-PackageName() {
  param(
    [string]$a
  )

  switch -w ( $a ) {
	  'sourcetree' {
		  $PackageUrl = "https://www.atlassian.com/software/sourcetree"
	  }
  }

  return $PackageUrl
}

function Get-JavaSiteUpdates {
  param(
    [string]$Package,
    [string]$Title,
    [string]$Wait = 4
  )

  $regex = '([\d]{0,2}[\.][\d]{0,2}[\.][\d]{0,2}[\.][\d]{0,5})'
  $page = Invoke-WebRequest -Uri "https://www.atlassian.com/software/sourcetree" -UseBasicParsing
  $url32 = $page.Links | ? href -match $regex | select -expand href | select -First 1
  $version = (Get-Version $url32)

  @{
    PackageName  = $Package
	  Title        = $Title
	  Version	     = $version
	  URL32		     = $url32
	  ReleaseNotes = "https://product-downloads.atlassian.com/software/sourcetree/windows/ga/ReleaseNotes_$version.html"
  }
}
