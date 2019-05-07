function Get-PackageName() {
  param(
    [string]$a
  )

  switch -w ( $a ) {
	  'sourcetree' {
		  $PackageUrl = "https://www.sourcetreeapp.com/enterprise"
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
  $url = Get-PackageName $Package
  $ie = New-Object -comobject InternetExplorer.Application
  $ie.Navigate2($url) 
  $ie.Visible = $false

  while($ie.ReadyState -ne $Wait) {
    Start-Sleep -Seconds 20
  }

  foreach ( $_ in $ie.Document.getElementsByTagName("a") ) {
    $url = $_.href;
    if ( $url -match $regex) {
      $yes = $url | Select-Object -last 1
      $version = $Matches[0]
      break;
    }
  }

  $ie.quit()

  if ( $version.endswith(".") ) {
    $version = Get-Version $yes
  }

  @{
    PackageName  = $Package
	  Title        = $Title
	  Version		   = $version
	  URL32		     = $yes
	  ReleaseNotes = "https://www.sourcetreeapp.com/update/windows/ga/ReleaseNotes_$version.html"
  }
}
