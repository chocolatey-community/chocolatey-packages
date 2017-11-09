import-module au

$domain   = 'http://www.7-zip.org/'
$releases = "${domain}download.html"

function global:au_SearchReplace {
  @{
    "$($Latest.PackageName).nuspec" = @{
      "(\<dependency .+?`"$($Latest.PackageName).install`" version=)`"([^`"]+)`"" = "`$1`"[$($Latest.Version)]`""
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest $releases

  $download_page.AllElements | ? innerText -match "^Download 7\-Zip ([\d\.]+) \([\d]{4}[\-\d]+\)" | select -First 1 | Out-Null
  if ($Matches[1] -and ($Matches[1] -match '^[\d\.]+$')) { $version = $Matches[0] }

  $URLS = $download_page.links | ? href -match "7z$($version -replace '\.','')(\-x64)?\.exe$" | select -expand href

  $url32 = $URLS | ? { $_ -notmatch "x64" } | select -first 1
  $url64 = $URLS | ? { $_ -match "x64" } | select -first 1
  $url_extra = $download_page.links | ? href -match "7z$($version -replace '\.','')\-extra\.7z" | select -first 1 -expand href

  @{
    URL32     = $domain + $url32
    URL64     = $domain + $url64
    URL_EXTRA = $domain + $url_extra
    Version   = [version]$version
  }
}

if ($MyInvocation.InvocationName -ne '.') {
  update -ChecksumFor none
}
